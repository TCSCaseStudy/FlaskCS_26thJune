from app import app
from flask_mysqldb import MySQL
from flask import Flask, render_template, request, redirect, url_for, session, jsonify, flash
import MySQLdb.cursors
import config,random,hashlib
import time,datetime


app.secret_key = config.Config.SECRET_KEY
# ------------------ RIYA ----------------------
# for xampp
# app.config['MYSQL_PASSWORD'] = ''
# ----------------------------------------------
# ------------------ MILI ----------------------
app.config['MYSQL_PASSWORD'] = 'password'
# ----------------------------------------------
# ------------------ COMMON --------------------
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_DB'] = 'hospital'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# ----------------------------------------------
mysql = MySQL(app)

@app.route("/")
@app.route('/login', methods=['GET', 'POST'])
def login():
    logout()
    # Output message if something goes wrong...
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        h = hashlib.md5(password.encode())
        digest = h.hexdigest()
        ts = time.time()
        timestamp = datetime.datetime.fromtimestamp(
            ts).strftime('%Y-%m-%d %H:%M:%S')

        # Check if account exists using MySQL
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT * FROM userstore WHERE id = %s AND pass = %s', (username, digest))
        # Fetch one record and return result
        account = cursor.fetchone()
        # If account exists in accounts table in out database
        if account:
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            try:
                cursor.execute('update userstore set ts=%s where id=%s',(timestamp,username))
                mysql.connection.commit()
            except Exception as e:
                return str(e)
            if account['type'] == 'p':
                session['p_login'] = True
            elif account['type'] == 'd':
                session['d_login'] = True
            elif account['type'] == 'r':
                session['r_login'] = True
            # Redirect to home page
            return redirect(url_for('welcome'))
        else:
            # Account doesnt exist or username/password incorrect
            msg = 'Incorrect username/password!'
    # Show the login form with message (if any)
    return render_template("includes/login.html", msg=msg)


@app.route('/register', methods=['GET', 'POST'])
def register():
    # Output message if something goes wrong...
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'dept' in request.form:
        username = request.form['username']
        password = request.form['password']
        h = hashlib.md5(password.encode())
        digest = h.hexdigest()
        dept = request.form['dept']
        ts = time.time()
        timestamp = datetime.datetime.fromtimestamp(
            ts).strftime('%Y-%m-%d %H:%M:%S')
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT * FROM userstore WHERE id = %s AND pass = %s', (username, digest))
        # Fetch one record and return result
        account = cursor.fetchone()
        # If account exists in accounts table in out database
        if account:
            msg='Account already exists. Please use login.'
            return render_template("includes/register.html",msg=msg)
        else:
            try:
                cursor.execute('INSERT INTO userstore values(%s,%s,%s,%s)',
                               (username, digest, timestamp, dept))
                mysql.connection.commit()
                msg='User Registered Successfully'
            except:
                msg='Something went wrong. Please try again'
                return render_template("includes/register.html",msg=msg)
            finally:
                cursor.close()
    return render_template("includes/register.html", msg=msg)


@app.route("/logout")
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('p_login', False)
   session.pop('d_login', False)
   session.pop('r_login', False)
   return redirect(url_for('login'))


@app.route("/welcome")
def welcome():
    return render_template("includes/welcome.html")


@app.route("/createPatient",methods=['GET', 'POST'])
def createPatient():
    return render_template("includes/createPatient.html")


@app.route("/updatePatient", methods=['GET', 'POST'])
def updatePatient():
    return render_template("includes/updatePatient.html")


@app.route("/deletePatient", methods=['GET', 'POST'])
def deletePatient():
    return render_template("includes/deletePatient.html")


@app.route("/viewAllPatients", methods=['GET', 'POST'])
def viewAllPatients():
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT ws_pat_id,ws_pat_name,ws_age,ws_adrs,ws_doj,ws_rtype FROM patient WHERE ws_status = 'Active' ")
    patientData = cursor.fetchall()
    print(patientData)
    return render_template("includes/viewAllPatients.html", patientData=patientData, viewAllPatients=True)



@app.route("/searchPatients", methods=['GET', 'POST'])
def searchPatients():
    
    cursor = mysql.connection.cursor()
    #Fetching the Id of the patient and storing it in Id variable
    if request.method == 'POST' and 'Id' in request.form:
        Id = request.form["Id"]
        
        if Id.isdigit():   
            
            cursor.execute("SELECT * FROM patient WHERE ws_pat_id=%s", (Id,))
            patientData = cursor.fetchone()
            
            cursor.close()
            if patientData:
                
                
                flash("Data Found")
                return render_template('includes/searchPatients.html',patientData=patientData,patientId=Id,msg="success")
            #else pass the error message
            else:
                flash("No Data Found")
        else:
            flash("Please enter valid data")
            return render_template("includes/searchPatients.html")    
      
    return render_template("includes/searchPatients.html") 


@app.route("/patientBilling", methods=['GET', 'POST'])
def patientBilling():
    return render_template("includes/patientBilling.html")


@app.route("/getPatientDetails", methods=['GET', 'POST'])
def getPatientDetails():
    msg=""
    if request.method == 'POST':
        patientid = request.form['patientid']
        cursor = mysql.connection.cursor()
        cursor.execute(
        'SELECT ws_pat_id AS PatientID, ws_pat_name AS PatientName,ws_age AS Age, ws_adrs AS Address, ws_doj AS DateofAdmission FROM patient WHERE ws_pat_id = {}'. format(patientid))
        data = cursor.fetchall()
        if not len(data):
            msg= "Patient with this Id does not exist"
        cursor.close()

        cur = mysql.connection.cursor()
        cur.execute(
        'SELECT medicines.ws_med_name AS MedicineName, medicines.ws_qty AS QuantityIssued, meds_master.ws_rate AS RateofTheMedicine, (medicines.ws_qty*meds_master.ws_rate)AS Amount FROM medicines,meds_master WHERE medicines.ws_med_name=meds_master.ws_med_name and medicines.ws_pat_id = {}'. format(patientid))
        data2 = cur.fetchall()
        cur.close()

        return render_template("includes/getPatientDetails.html",data=data, data2=data2 , msg=msg , button_msg="Issue Medicines")
    else:

        return render_template("includes/getPatientDetails.html", msg=msg)


@app.route("/issueMeds", methods=['GET', 'POST'])
def issueMeds():
    return render_template("includes/issueMeds.html")


@app.route("/diagnostics", methods=['GET', 'POST'])
def diagnostics():
    return render_template("includes/diagnostics.html")

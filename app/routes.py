from app import app
from flask_mysqldb import MySQL
from flask import Flask, render_template, request, redirect, url_for, session, jsonify, flash
import MySQLdb.cursors
import config,random,hashlib,json
import time,datetime
from datetime import date

app.secret_key = config.Config.SECRET_KEY
# ------------------ RIYA ----------------------
# for xampp
# app.config['MYSQL_PASSWORD'] = ''
# ----------------------------------------------
# ------------------ MILI ----------------------
# app.config['MYSQL_PASSWORD'] = 'password'
# ----------------------------------------------
# ------------------ COMMON --------------------
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_DB'] = 'hospital'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# ----------------------------------------------

# for ubuntu user
# app.config['MYSQL_UNIX_SOCKET'] = '/opt/lampp/var/mysql/mysql.sock'
# ----------------------------------------------
mysql = MySQL(app)

@app.route("/")
@app.route('/login', methods=['GET', 'POST'])
def login():
    logout()
    popSession()
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
            except:
                pass
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
    popSession()
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
    popSession()
    session.pop('loggedin', None)
    session.pop('p_login', False)
    session.pop('d_login', False)
    session.pop('r_login', False)
    return redirect(url_for('login'))


@app.route("/welcome")
def welcome():
    popSession()
    return render_template("includes/welcome.html")


@app.route("/createPatient",methods=['GET', 'POST'])
def createPatient():
    msg = ''
    message=''
    ts = time.time()
    timestamp = datetime.datetime.fromtimestamp(
        ts).strftime('%Y-%m-%d')
    if request.method == 'POST' and request.form.get('ssn'):
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        try:
            cursor.execute(
                "INSERT INTO patient(ws_ssn,ws_pat_id,ws_adrs,ws_age,ws_doj,ws_rtype,ws_status,ws_pat_name,ws_pat_city,ws_pat_state) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", (int(request.form['ssn']), int(random.randint(100000000, 999999999)), request.form['address'], int(request.form['age']), request.form['doj'], request.form['bedType'], 'Active', request.form['name'], request.form['city'], request.form['state']))
            mysql.connection.commit()
            flash('Patient creation initiated successfully')
            msg='success'
        except:
            flash("Failed to add Patient. Please try again with different field values!")
            return render_template("includes/createPatient.html", msg=msg, message=message,timestamp=timestamp)
        finally:
            cursor.close()
    return render_template("includes/createPatient.html", msg=msg,message=message,timestamp=timestamp)


@app.route("/updatePatient", methods=['GET', 'POST'])
def updatePatient():
    msg = ''
    message = ''
    ts = time.time()
    timestamp = datetime.datetime.fromtimestamp(
        ts).strftime('%Y-%m-%d')
    if request.method == 'POST' and request.form.get('pid'):
        pid = request.form['pid']
        name = request.form['name']
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * from patient where ws_pat_id=%s',[pid])
        res=cursor.fetchone()
        if not res:
            flash("Patient not registered. Please check the ID")
            return render_template("includes/updatePatient.html", msg=msg, message=message,timestamp=timestamp)
        if len(pid)>0 and len(name)>0:
            age = request.form['age']
            doj = request.form['doj']
            bedType = request.form['bedType']
            address = request.form['address']
            state = request.form['state']
            city = request.form['city']
            try:
                cursor.execute('Update patient set ws_pat_name=%s,ws_age=%s,ws_doj=%s,ws_rtype=%s,ws_adrs=%s,ws_pat_state=%s,ws_pat_city=%s where ws_pat_id=%s',
                            (name, age, doj, bedType, address, state, city, pid))
                mysql.connection.commit()
                flash('Patient update initiated successfully')
                msg = 'success'
                return render_template("includes/updatePatient.html", name=name, age=age, doj=doj, bedType=bedType, address=address, state=state, city=city, pid=pid,msg=msg,message=message,timestamp=timestamp)
            except:
                flash("Failed to update Patient details. Please try again with different field values!")
                return render_template("includes/updatePatient.html", msg=msg, message=message, timestamp=timestamp)
            finally:
                cursor.close()

        elif len(pid)>0 and len(name)==0:
            msg='info'
            flash("Patient Found. Edit details to update!")
            return render_template("includes/updatePatient.html", pid=res['ws_pat_id'],name=res['ws_pat_name'],age=res['ws_age'],doj=res['ws_doj'],bedType=res['ws_rtype'],address=res['ws_adrs'],state=res['ws_pat_state'],city=res['ws_pat_city'],msg=msg,message=message,timestamp=timestamp)
        else:
            flash("Patient not registered. Please check the ID")
    flash("Enter Patient ID only")
    return render_template("includes/updatePatient.html", msg='info', message=message,timestamp=timestamp)



@app.route("/deletePatient", methods=['GET', 'POST'])
def deletePatient():
    popSession()
    cursor = mysql.connection.cursor()
    #Fetching the Id of the patient and storing it in Id variable
    if request.method == 'POST' and 'Id' in request.form:
        Id = request.form["Id"]
        session['id']=Id
        if Id.isdigit():
            cursor.execute("SELECT * FROM patient WHERE ws_pat_id=%s", (Id,))
            patientData = cursor.fetchone()
            cursor.close()
            if patientData:
                flash("Patient Data Found")
                return render_template('includes/deletePatient.html',patientData=patientData,patientId=Id,msg="success")
            #else pass the error message
            else:
                flash("No Patient Data Found")
        else:
            flash("Please enter a valid ID")
            return render_template("includes/deletePatient.html")
    return render_template("includes/deletePatient.html")


@app.route("/delete", methods=['POST'])
def delete():
    cursor = mysql.connection.cursor()
    try:
        print(session['id'])
        cursor.execute('delete from patient where ws_pat_id=%s',[session['id']])
        mysql.connection.commit()
        flash("Patient deletion initiated successfully")
        return render_template('includes/deletePatient.html', msg="success")
    except Exception as e:
        flash(str(e))
        return render_template('includes/deletePatient.html', msg="success")



@app.route("/viewAllPatients", methods=['GET', 'POST'])
def viewAllPatients():
    popSession()
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT ws_pat_id,ws_pat_name,ws_age,ws_adrs,ws_doj,ws_rtype FROM patient WHERE ws_status = 'Active' ")
    patientData = cursor.fetchall()
    return render_template("includes/viewAllPatients.html", patientData=patientData, viewAllPatients=True)



@app.route("/searchPatients", methods=['GET', 'POST'])
def searchPatients():
    popSession()
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
    popSession()
    if request.method == 'POST' and 'Id' in request.form:
        patientId = request.form['Id']
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM patient WHERE ws_pat_id=%s AND ws_discharge IS NULL', [patientId])
        patient = cursor.fetchone()
        if patient:
            total_charge = room_charge = med_charge = diagnos_charge = float(0)
            today = date.today()
            patient['ws_discharge'] = today
            
            doj = patient['ws_doj']
            doj_date = str(doj).split('-')
            d2_y = int(doj_date[0])
            d2_m = int(doj_date[1])
            d2_d = int(doj_date[2])
            d2 = date(d2_y, d2_m, d2_d)

            no_days = (today - d2).days + 1
            if not no_days > 0:
                flash('Error contact to db admin', 'danger')
                return render_template("includes/patientBilling.html")
            if patient['ws_rtype'] == 'General Ward':
                room_charge = no_days * 2000
            elif patient['ws_rtype'] == 'Semi Sharing':
                room_charge = no_days * 4000
            elif patient['ws_rtype'] == 'Single Room':
                room_charge = no_days * 8000
            # fetch medicine details
            cursor.execute(
                'SELECT ws_med_name, ws_qty from medicines where ws_pat_id=%s', [patientId])
            medicine = cursor.fetchall()
            # fetch medicine rate
            cursor.execute("SELECT ws_med_name, ws_rate FROM meds_master WHERE ws_med_name IN(" +
                           "SELECT DISTINCT ws_med_name FROM medicines where ws_pat_id=%s)", [patientId])
            medrate = cursor.fetchall()
            medratelist = {}
            for med in medrate:
                medratelist[med['ws_med_name']] = float(med['ws_rate'])
            # calculate medicine charge
            for med in medicine:
                med_charge += med['ws_qty'] * medratelist[med['ws_med_name']]
            
            # fetch diagnostics list
            cursor.execute(
                "SELECT diagnostics.ws_test_id AS test_id, diagnostics.ws_diagn AS diagnosis, tests.ws_test_chrg AS charge FROM diagnostics LEFT JOIN tests ON diagnostics.ws_test_id=tests.ws_test_id AND diagnostics.ws_pat_id=%s", [patientId])
            diganosis = cursor.fetchall()
            if diganosis:
                for diag in diganosis:
                    diagnos_charge += diag['charge']

            total_charge = room_charge + med_charge + diagnos_charge
            # if medicine:
            #     flash('Data found', 'success')
            cursor.close()
            return render_template("includes/patientBilling.html", patient=patient, no_days=no_days, medicine=medicine, medratelist=medratelist, diganosis=diganosis, room_charge=room_charge, med_charge=med_charge, diagnos_charge=diagnos_charge, total_charge=total_charge)
        else:
            cursor.close()
            flash('Either no patient found or bill generated alredy', 'danger')
    return render_template("includes/patientBilling.html")


@app.route("/confirmBilling", methods=['GET'])
def confirmBilling():
    patientId = request.args.get('patientId')
    rbill = request.args.get('rbill')
    mbill = request.args.get('mbill')
    dbill = request.args.get('dbill')
    total = request.args.get('total')
    if not (patientId is None or rbill is None or mbill is None or total is None):
        cursor = mysql.connection.cursor()
        try:
            today = date.today()
            print(today)
            cursor.execute(
                'UPDATE patient SET ws_discharge=%s WHERE ws_pat_id=%s', (str(today), patientId))
            cursor.execute('INSERT INTO bills(dbill,mbill,rbill,pid) VALUES(%s,%s,%s,%s)', (dbill, mbill, rbill, patientId))
            mysql.connection.commit()
            flash('Bill generated successfully', 'success')
        except:
            flash('Some error occured, please retry!', 'danger')
        finally:
            cursor.close()
    return redirect(url_for('patientBilling'))
    

@app.route("/getPatientDetails", methods=['GET', 'POST'])
def getPatientDetails():
    popSession()
    msg=""
    button_msg=""
    if request.method == 'POST':
        patientid = request.form['patientid']
        session['patientid'] = patientid
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(
        'SELECT ws_pat_id AS PatientID, ws_pat_name AS PatientName,ws_age AS Age, ws_adrs AS Address, ws_doj AS DateofAdmission FROM patient WHERE ws_pat_id = {}'. format(patientid))
        data = cursor.fetchall()
        #if no records fetched display Id does not exist
        if not len(data):
            msg= "Patient with this Id does not exist"
        cursor.close()

        cur = mysql.connection.cursor()
        cur.execute(
        'SELECT medicines.ws_med_name AS MedicineName, medicines.ws_qty AS QuantityIssued, meds_master.ws_rate AS RateofTheMedicine, (medicines.ws_qty*meds_master.ws_rate)AS Amount FROM medicines,meds_master WHERE medicines.ws_med_name=meds_master.ws_med_name and medicines.ws_pat_id = {}'. format(patientid))
        data2 = cur.fetchall()

        #Fetching Data of Header for medicines issued
        res = [ele for key in data2 for ele in key]
        medhead=[i for n, i in enumerate(res) if i not in res[:n]]
        cur.close()

        if len(msg)==0:
            button_msg="Issue medicines"
        return render_template("includes/getPatientDetails.html",data=data, data2=data2 , medhead=medhead, msg=msg , button_msg=button_msg)
    else:

        return render_template("includes/getPatientDetails.html", msg=msg , button_msg=button_msg)


#class for storing data entered
class Medicine:
    mlist=[]

    def setMed(self,pt):
        self.mlist=pt

    def getMed(self):
        return self.mlist

    def addmed(self,med):
        self.mlist.append(med)

#Object Creation
obj = Medicine()

@app.route("/issueMeds", methods=['GET', 'POST'])
def issueMeds():
    msg=""
    patientid = session.get('patientid', None)
    if request.method == 'POST':
        status=""
        medname = request.form['medname']
        qty = request.form['qty']
        qty= int(qty)
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(
        'SELECT ws_med_name AS MedicineName, ws_med_qty AS Quantity,ws_rate AS Rate, ws_rate AS Amount FROM meds_master WHERE ws_med_name =  %s', [medname])
        med = cursor.fetchall()
        cursor.close()
        #Check if the medicine exists in database
        if len(med)!=0:

            #Checking if required medicine quantity is available
            if med[0]['Quantity']>qty:
                status='Available'
                med[0]['Quantity']=qty
                med[0]['Amount']=qty*med[0]['Rate']
                msg="Click to Add More Medicines"

                #Adding and storing in object for record
                obj.addmed([med[0]['MedicineName'],med[0]['Quantity'],med[0]['Rate'],med[0]['Amount']])

                return render_template("includes/issueMeds.html",patientid=patientid, status=status, color="green", data=obj.getMed(), msg=msg, medname=medname)
        else:

            #If not available display not Available
            status='Not Available'
            msg="Click to Add Another Medicine"
            return render_template("includes/issueMeds.html",patientid=patientid, status=status, color="red", data=obj.getMed(), msg=msg)
    else:
        return render_template("includes/issueMeds.html", patientid=patientid)

#If medicines are isssued Successfully load medIssueSuccess
@app.route("/medIssueSuccess")
def medIssueSuccess():
    patientid = session.get('patientid', None)

    #fetching the value of object
    l=obj.getMed()

    #Iterating to find out name and quantity required for each medicine in object
    for medicine in l:
        name=medicine[0]
        reqQty=int(medicine[1])
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

        #Fetching Medicine Quantity in database
        cursor.execute(
        'SELECT ws_med_qty AS Quantity FROM meds_master WHERE ws_med_name =  %s', [name])
        med = cursor.fetchall()
        cursor.close()

        #Storing fetched quantity
        fetchedQuantity=int(med[0]['Quantity'])

        #Calculating new medicine quantity to be updated in database
        updatedQuantity=fetchedQuantity-reqQty
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        try:
            #Updating table meds_master with quantity
            cursor.execute('UPDATE meds_master SET ws_med_qty = %s WHERE ws_med_name  =  %s' , (updatedQuantity,name))
            mysql.connection.commit()
        except Exception as e:
            return str(e)

        try:
            #Updating medicines for patients in meds table
            cursor.execute('INSERT INTO medicines(ws_pat_id,ws_med_name,ws_qty) VALUES(%s,%s,%s)', (patientid,name,reqQty))
            mysql.connection.commit()
        except Exception as e:
            return str(e)
    return render_template("includes/medIssueSuccess.html")


@app.route("/getPatientDiagnosticDetails", methods=['GET', 'POST'])
def getPatientDiagnosticDetails():
    popSession()
    if request.method == 'POST' and 'Id' in request.form:
        Id = request.form["Id"]
        if Id.isdigit():
            cursor = mysql.connection.cursor()
            cursor.execute("SELECT ws_pat_id,ws_pat_name,ws_age,ws_adrs,ws_doj,ws_pat_city,ws_pat_state FROM patient WHERE ws_pat_id=%s", (Id,))
            patientData = cursor.fetchone()
            if patientData:
                cursor.execute("SELECT m.ws_med_name FROM patient p,medicines m WHERE p.ws_pat_id=m.ws_pat_id AND p.ws_pat_id=%s", (Id,))
                medicine=cursor.fetchall()
                patientData['ws_med_name']=''
                if medicine:
                    med=[]
                    for x in medicine:
                        med.append(x['ws_med_name'])

                    patientData['ws_med_name']=med
                cursor.close()
                return render_template('includes/getPatientDiagonsticDetails.html', patientData=patientData)

            else:
                cursor.close()
                flash("Patient data doesn't exist")
        else:
            flash("Please Enter Valid Data")
            return render_template("includes/getPatientDiagonsticDetails.html")
    return render_template("includes/getPatientDiagonsticDetails.html")


@app.route("/diagnostics/<patId>/<msg>")
@app.route("/diagnostics/<patId>/", methods=['GET', 'POST'] ,defaults= {'msg': ""})
def diagnostics(patId,msg):
    if msg=="success":
        flash("Diagnostic Added Successfully")
    else:
        msg="Not"

    if "addedTests" not in session:
        session["addedTests"]=[]

    if patId:
        id = patId
        cursor = mysql.connection.cursor()
        if "diagnosticsData" not in session:
            session["diagnosticsData"]=[]
            cursor.execute('select ws_test_name,ws_test_id,ws_test_chrg from tests')
            session["diagnosticsData"] = cursor.fetchall()
        test_names=[]
        for x in session["diagnosticsData"]:
            test_names.append(x['ws_test_name'])

        cursor.execute("SELECT t.ws_test_name,t.ws_test_chrg FROM diagnostics d, tests t WHERE d.ws_test_id=t.ws_test_id AND d.ws_pat_id=%s",(id,))
        patientTests=cursor.fetchall()

        if request.method=="POST" and 'tests' in request.form :

            test= request.form.get('tests')

            for x in session["diagnosticsData"]:
                if x['ws_test_name']==test:
                    test_id = x['ws_test_id']
                    test_charge = x['ws_test_chrg']
            for x in session["addedTests"]:
                if test==x['test_name']:
                    break
            else:
                session["addedTests"] += [{'pat_id':id,'test_name':test,'test_id':test_id,'test_charge':test_charge}]
            print(session["addedTests"])

        return render_template("includes/diagnostics.html", Id = id, test_names=test_names,msg=msg,patientTests=patientTests,addedTests=session["addedTests"])

@app.route('/process', methods =['POST'])
def process():
    cursor = mysql.connection.cursor()
    if request.method=="POST"  :
        try:
            for x in session["addedTests"]:
                id=x['pat_id']
                cursor.execute('INSERT INTO diagnostics(ws_pat_id,ws_diagn,ws_test_id) VALUES(%s,%s,%s)',(x['pat_id'],x['test_name'],x['test_id']))
                mysql.connection.commit()
            msg="success"

        except:
            msg="something went wrong"
        finally:
            cursor.close()
    popSession()
    return redirect("/diagnostics/"+id+"/"+msg)

def popSession():
    session.pop("diagnosticsData",None)
    session.pop("addedTests",None)

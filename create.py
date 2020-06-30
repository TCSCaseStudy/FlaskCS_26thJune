from app import app
from flask_mysqldb import MySQL
from flask import Flask, render_template, request, redirect, url_for, session,flash
import MySQLdb.cursors
import json



import random


mysql = MySQL(app)


@app.route("/createPatient",methods=["GET", "POST"])
def createPatient():

  msg="abc"
  if request.method == 'POST' and 'ssnid' in request.form and 'name' in request.form and 'Age' in request.form and 'doa' in request.form and 'bedType' in request.form and 'Address' in request.form and 'City' in request.form and 'State' in request.form:  
    ssnid=int(request.form.get('ssnid'))
    name=request.form.get('name')
    Age=int(request.form.get('Age'))
    doa=request.form.get('doa')
    bedType=request.form.get('bedType')
    Address=request.form.get('Address')
    City=request.form.get('City')
    State=request.form.get('State')
    
    cur = mysql.connection.cursor()
    
    
    x=int(random.randint(100000000,999999999))
    try:
     cur.execute("INSERT into patient7 (ws_ssn,ws_pat_id,ws_name,ws_age,ws_doa,ws_rtype,ws_address,ws_city,ws_state,ws_status) values (%s,%s,%s, %s,%s,%s,%s,%s,%s,%s)",(ssnid,x,name,Age,doa,bedType,Address,City,State,"abc"))
     mysql.connection.commit()
     msg="User Created Sucessfully"
    except (MySQLdb.Error, MySQLdb.Warning) as e:
     msg="An error occured"
     
    #cur.commit()
    
    print(cur)
  return render_template("includes/createPatient.html",msg=msg)
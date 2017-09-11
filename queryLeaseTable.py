#!/usr/bin/python
ip="37.128.196.142"
import MySQLdb
db = MySQLdb.connect("localhost","root","nmaps","docsis" )
# prepare a cursor object using cursor() method
cur = db.cursor()
#cur.execute("SELECT * from lease_table where ip_address = '37.128.196.142'")
cur.execute("SELECT * from lease_table where ip_address = %s limit 1" , (ip))
for row in cur.fetchall():
    print "IP: " + row[3] + "   " + "MAC: " + row[1]

# disconnect from server
db.close()

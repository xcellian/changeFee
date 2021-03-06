# -*- coding: utf-8 -*-
"""
Created on Thu Dec  7 13:54:11 2017

@author: pang
"""

import pyodbc
import sys
import datetime
import time

def maximise():
    ADD_PARK_FEE_VALUE = 300000
    DAY_MAX_FEE_VALUE = 600000
    
    conn = wilson_conn()
    cursor = conn.cursor()
    key = get_cd(cursor)
    db_conn, db_name = connect_to_database(key)
    db_cursor = db_conn.cursor()

    row = get_data(db_cursor, db_name, key)
    
    if(row.day_max_fee < DAY_MAX_FEE_VALUE):
        backup_data(cursor, row, key)

    # update max values
    message("Updating ADD_PARK_FEE {} to {}...".format(key, ADD_PARK_FEE_VALUE))
    message("Updating DAY_MAX_FEE {} to {}...".format(key, DAY_MAX_FEE_VALUE))

    update_query = """update {}.dbo.CPK_Payment 
        set day_max_fee = {}, add_park_fee = {}, add_park_tm = {}
        where parkmaster_cd = '{}' and 
        park_zone_cd = '{}' and 
        use_yn = '{}' and 
        car_type_cd = '{}'""".format(db_name, DAY_MAX_FEE_VALUE, ADD_PARK_FEE_VALUE, 
        row.add_park_tm, key, row.park_zone_cd, row.use_yn, row.car_type_cd)
    try_execute(db_cursor, update_query)
    
    if(db_cursor.rowcount == 0):
        message("UPDATE FAILED")
        sys.exit(1)

    db_cursor.commit()
    message("UPDATE SUCCESS")
    
    message("===========DONE===========")
    conn.close()
    db_conn.close()
    
def restore():
    conn = wilson_conn()
    cursor = conn.cursor()
    key = get_cd(cursor)
    db_conn, db_name = connect_to_database(key)
    db_cursor = db_conn.cursor()
    
    # this gets data from db_conn *data returned is unused atm*
    #get_data(db_cursor, db_name, key)
    
    # get backup data
    query = """select * from wilson.dbo.CPK_Backup where parkmaster_cd = '{}'""".format(key)
    try_execute(cursor, query)
    row = cursor.fetchone()
    
    # restore with backup data 
    try:
        update_query = """update {}.dbo.CPK_Payment 
        set day_max_fee = {}, add_park_fee = {}, add_park_tm = {}
        where parkmaster_cd = '{}' and 
        park_zone_cd = '{}' and 
        use_yn = '{}' and 
        car_type_cd = '{}'""".format(db_name, row.day_max_fee, row.add_park_fee, row.add_park_tm, key, \
        row.park_zone_cd, row.use_yn, row.car_type_cd)
    except:
        message("Cannot update with query")
        sys.exit(1)
    message("Restoring ADD_PARK_FEE {} to {}...".format(key, row.add_park_fee))
    message("Restoring DAY_MAX_FEE {} to {}...".format(key, row.day_max_fee))

    try_execute(db_cursor, update_query)
    if(db_cursor.rowcount == 0):
        message("RESTORE FAILED")
        sys.exit(1)
    db_cursor.commit()
    message("===========DONE===========")

    conn.close()
    db_conn.close()

def wilson_conn():
    return pyodbc.connect(
    r'DRIVER={SQL Server};'
    r'SERVER=localhost;'
    r'uid=sa;'
    r'pwd=!wilson2017;'
    )
    
def darae_conn(server):
    conn_str = "DRIVER={{SQL Server}}; SERVER={}; uid=sa; pwd=$pkdb2009#;".format(server)     
    message("Connecting to {}...".format(server))      
    conn = pyodbc.connect(conn_str)
    message("CONNECTION SUCCESS!")
    return conn
    
def connect_to_database(key):
    conn = None
    db_name = "DRPKDB"
    key2 = int(key)
    
    if key2 == 25:
        conn = darae_conn("192.168.125.102")
        db_name = "DRPKDB_25"
    elif (key2 >= 1 and key2 < 40):
        conn = darae_conn("192.168.100.102")
    # 2018.02.06 by jeremy
    #elif (key >= 40 and key <= 47):
    elif (key2 >= 40 and key2 <= 50):
        conn = darae_conn("192.168.100.105")
    elif conn == None:
        message("Could not connect to a server given key: {}".format(key2))
        sys.exit(1)
    return conn, db_name

def get_data(db_cursor, db_name, key):
    select_info = """select parkmaster_cd, park_zone_cd, car_type_cd, use_yn,
    add_park_tm, add_park_fee, day_max_fee 
    from {}.dbo.CPK_Payment 
    where parkmaster_cd = '{}' and 
    park_zone_cd = '1' and 
    use_yn = 'Y' and 
    car_type_cd = 'PK0302'""".format(db_name, key)
    try_execute(db_cursor, select_info)
    data = db_cursor.fetchall()
    if(data == []):
        message("Cannot find matching row in CPK_Payment")
        sys.exit(1)
    return data[0]
    
def get_cd(cursor):
    select_query = "select PARKMASTER_CD_ACS from wilson.dbo.WPK_CARPARK_MASTER where PARK_NUMBER = '{}' and PARK_TYPE = 1".format(sys.argv[2])
    cursor.execute(select_query)
    result = cursor.fetchall()
    if(len(result) != 1):
        message("Cannot find a matching ID to park number.")
        sys.exit(1)
    return result[0][0]

def backup_data(cursor, row, key):
    try:
        query  = """update wilson.dbo.CPK_Backup 
        set day_max_fee = {}, add_park_tm = {}, add_park_fee = {} 
        where parkmaster_cd = '{}'""".format(row.day_max_fee, row.add_park_tm, row.add_park_fee, key)
    except:
        message("Error in update query")
        sys.exit(1)
    try_execute(cursor, query)
    
    if(cursor.rowcount == 0):
        query  = """insert into wilson.dbo.CPK_Backup (parkmaster_cd, day_max_fee, 
        add_park_tm, add_park_fee, park_zone_cd, use_yn, car_type_cd) 
        values ('{}', {}, {}, {}, '{}', '{}', '{}')""".format(key, row.day_max_fee, \
        row.add_park_tm, row.add_park_fee, row.park_zone_cd, row.use_yn, row.car_type_cd)
        try_execute(cursor, query)
    cursor.commit()
    message("BACKUP SUCCESS")
    
def try_execute(cursor, query):
    try:
        cursor.execute(query)
    except:
        message("There was a problem executing: '{}'".format(query))        
        sys.exit(1)
        
def message(msg):
    print(msg)
    with open("C:/logs/changeFee/pyLogs/log.txt", "a") as file:
        ts = time.time()
        nice_timestamp = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d %H:%M:%S')
        file.write("{} : {}\n".format(nice_timestamp, msg))

if __name__ == "__main__":
    if sys.argv[1] == 'restore':
        restore()
    elif sys.argv[1] == 'max':
        maximise()
    else:
        message("Incorrect arguments. ([max|restore],[id])")
        sys.exit(1)
    sys.exit(0)
#!/usr/bin/python
# -*- coding: utf8 -*-
#
#    Copyright 2014,2018 Mario Gomez <mario.gomez@teubi.co>
#
#    This file is part of MFRC522-Python
#    MFRC522-Python is a simple Python implementation for
#    the MFRC522 NFC Card Reader for the Raspberry Pi.
#
#    MFRC522-Python is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    MFRC522-Python is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with MFRC522-Python.  If not, see <http://www.gnu.org/licenses/>.
#

import RPi.GPIO as GPIO
import MFRC522
import signal
import IOT
import TOF10120
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
cred = credentials.Certificate('/home/pi/Desktop/sikproject-firebase-adminsdk-jn6o3-82202a2c7a.json')

app = firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection(u'users')
continue_reading = True

sets_num = 0
repetition = 0
weight = 0
MachineName = 'LatPullDown'
yaw_data = []
roll_data = []

# Capture SIGINT for cleanup when the script is aborted
def end_read(signal,frame):
    global continue_reading
    print("Ctrl+C captured, ending read.")
    continue_reading = False
    GPIO.cleanup()

# Hook the SIGINT
signal.signal(signal.SIGINT, end_read)

# Create an object of the class MFRC522
MIFAREReader = MFRC522.MFRC522()

print("Press Ctrl-C to stop.")

while continue_reading:
    
    # Scan for cards    
    (status,TagType) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)

    # If a card is found
    if status == MIFAREReader.MI_OK:
        print("Card detected")
    
    # Get the UID of the card
    (status,uid) = MIFAREReader.MFRC522_Anticoll()

    # If we have the UID, continue
    if status == MIFAREReader.MI_OK:

        # Print UID
        print("Card read UID: ",uid[0], uid[1], uid[2], uid[3])
        Uid = str(uid[0])+str(uid[1])+str(uid[2])+str(uid[3])
        # This is the default key for authentication
        key = [0xFF,0xFF,0xFF,0xFF,0xFF,0xFF]
        
        # Select the scanned tag
        MIFAREReader.MFRC522_SelectTag(uid)

        # Authenticate
        status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A, 8, key, uid)

        # Check if authenticated
        if status == MIFAREReader.MI_OK:
            MIFAREReader.MFRC522_Read(8)
            MIFAREReader.MFRC522_StopCrypto1()
        else:
            print("Authentication error")
        
        #사용자 식별
        Target_ref = IOT.Search_User(db,Uid,users_ref)
        
        if Target_ref != False:
            print('ok')
            Target = Target_ref.get()
        else:
            NewUser = 'user'+str(IOT.Count_user(users_ref))
            IOT.Set_New_User(db,NewUser,Uid)
            IOT.Set_New_HealthRecord(db,NewUser,MachineName)
            

        today = IOT.Record_Day()
        repetition, weight, set_time, yaw_data= TOF10120.Measure(Target_ref)
        sets_num = IOT.Count_Sets(Target_ref,today)
        
        IOT.Update_HealthRecord(Target_ref,sets_num,repetition,weight,set_time,yaw_data,today)
        IOT.Set_TotalTime(Target_ref,today,MachineName)
        

        

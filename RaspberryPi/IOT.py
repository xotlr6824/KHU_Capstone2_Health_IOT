#!/usr/bin/python

from time import sleep
from turtle import right
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import time
import datetime as dt
#import MFRC522
import signal
#import RPi.GPIO as GPIO

userdata=[]
healthtime =0
weight = 0
left_proportion = 0
right_proportion = 0
sets = []
repetition = 0

MachineName = 'LatPullDown'

def Count_user(users_ref):
    docs = users_ref.stream()
    user_size = 0
    for i in docs:
        user_size +=1
    return user_size

def Count_Sets(Target_user_ref,today):
    docs = Target_user_ref.collection(u'record').document(today).collection(u'machine').document(MachineName).collection(u'sets').stream()
    sets_size = 0
    for i in docs:
        sets_size +=1
    return sets_size

#유저 태깅 대기 및 탐색
def Read_card():
    print('waiting...')
    users_ref = db.collection(u'users')
    uid = '24010422525'
    return uid

#rfid 카드 번호를 이용한 유저탐색
def Search_User(db,uid,users_ref):
    User = users_ref.where('Uid','==',uid).get()
    existCount = len(User)

    if existCount > 0:
        target_user = str(list(User)[0].id)
        Target_user_ref = db.collection(u'users').document(target_user)
        return(Target_user_ref)
    else:
        return False

#운동 날짜 기록
def Record_Day():
    x = dt.datetime.now()
    day = x.strftime('%Y%m%d')
    
    sleep(5)
    y = dt.datetime.now()
    day = y.strftime('%Y%m%d')
    print("today : ",day)
    
    return(day)


def Set_New_User(db,newuser,uid):
    users_ref = db.collection(u'users')
    users_ref.document(newuser).set({
        'Uid' : uid
    })
#새로운 날 세팅
def Set_New_HealthRecord(db,NewUser,MachineName):
    
    users_ref = db.collection(u'users')
    x = dt.datetime.now()
    today = x.strftime('%Y%m%d')
    users_ref.document(NewUser).collection(u'record').document(today).collection(u'machine').document(MachineName).collection(u'sets').document('1set').set({
        'repetition' : 0,
        'left' : 0,
        'right' : 0,
        'weight' : 0,
        'set_time' : 0
    })
    users_ref.document(NewUser).collection(u'record').document(today).set({
        'health_try': True
    })
    
    

def Update_HealthRecord(Target_user_ref,setNum,repetition,weight,set_time,yaw_data,today):
    Target_user_ref.collection(u'record').document(today).collection(u'machine').document(MachineName).collection(u'sets').document(str(setNum)+'set').set({
        'repetition' : repetition,
        'weight' : weight,
        'set_time' : set_time,
        'yaw_data' : yaw_data,
    })

def Set_TotalTime(Target_user_ref,today,MachineName):
    record_ref = Target_user_ref.collection(u'record').document(today)
    machine_ref = record_ref.collection('machine').document(MachineName)
    tt_ref = machine_ref.collection('sets').where(u'set_time',u'>',0).get()
    total = 0
    for ttime in tt_ref:
        total += ttime.to_dict()['set_time']
    print(total)
    machine_ref.set({
        'total_time' : total
    })
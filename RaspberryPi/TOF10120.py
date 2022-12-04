#!/usr/bin/python
from bluetooth import *
import socket
import time
from smbus import SMBus
bus = SMBus(1)
time.sleep(1)
#prev_distance = 200

TOF_socket = BluetoothSocket( RFCOMM )
TOF_socket.connect(("98:DA:60:02:BE:58", 1))
print("bluetooth connected!")

def range_mm(address):
    
    try:
      bus.write_byte(address,0)
      time.sleep(0.02)
      value = bus.read_byte(address) << 8 | bus.read_byte(address)
      time.sleep(0.05)
      return value

    except IOError:
      print('i2c address does not exist')
      pass
    
def Count_repetiton(Standard,repetition):
    yaw_data = []
    pitch_data = []
    start_time = time.time()
    try:
      while True:
        distance = range_mm(0x52)
        print("Recieve Data From MPU6050...")
        msg = TOF_socket.recv(1024)
        
        decode_msg = msg.decode('utf-8')
        data = decode_msg.split(' ')
        for item in data:
            yaw_data.append(item)
        
        print(msg.decode('utf-8'))
        if(distance< Standard+50):
            TOF_socket.send("finish")
            
            repetition+=1
            print(repetition,"repetition finish")
            finish_time = time.time()
            break 
    except KeyboardInterrupt:
      bus.close()
    
    set_time = finish_time - start_time
    return(repetition, set_time, finish_time,yaw_data)

repetition=0
sets=0
weight = 0
timecheck = 0
"""
if (Standard > 100) and (Standard ):

"""
def Measure(Target_ref):
    Training_Status = False
    repetition =0
    Standard = range_mm(0x52)
    print("Standard :",Standard)
    Sets_yaw_data =[]

    bus = SMBus(1)
    time.sleep(1)
    #prev_distance = 200


    finish_check = 0
    start_time =time.time()

    Standard = range_mm(0x52)
    if Standard >=95 and Standard <125:
      weight = 60
    elif Standard >=125 and Standard <155:
      weight = 55
    else:
      weight = 50

    try:
      while True:
        distance = range_mm(0x52)
        
        if(distance >= Standard +200):
            start_time = time.time()
            TOF_socket.send("start")
            Training_Status =True
            finish_check = 0
            repetition, set_time, finish_time,yaw_data = Count_repetiton(Standard,repetition)
            Sets_yaw_data.append(yaw_data)
        
        finish_time = time.time()
        finish_check = finish_time - start_time
        print(finish_check)
        #10초 동안 운동안하면 세트종료
        if finish_check > 10 and Training_Status:
          print("set_finish")
          break
    except KeyboardInterrupt:
      bus.close()
    print("Stopped")
    return(repetition,weight,set_time,yaw_data)

# 주제

## IOT Health Training 장비 개발



### 2016104103 컴퓨터공학과 곽태식


* Environment

    - MacBook m1 pro 32GB 1TB
    - macOS Ventura 13.0.1
    ----
    - Arduino Mega 2560
    - RaspberryPi 3 B+
    -------------
    - MPU6050
    - TOF10120
    - MFRC522
    - HC06
    --------------
    
    - Arduino IDE 2.0.2
    - VS code 1.67.2
    - Xcode 14.1
    - Android Studio 2020.3
    - Flutter 3.3.8
    - Python 3.9.13
    ----
    - firebase_core 2.3.0
    - firebase_auth 4.1.4
    - cloud_firestore 4.1.0
    - get 4.6.5



## Prerequisite


### PinMap

#### Arduino Mega 2560 PinMap
![arpinmap](https://user-images.githubusercontent.com/48917101/205257128-e4837df3-cd00-4bfc-a027-875d824aa3aa.png)


#### RaspberryPi PinMap
![pinmap](https://user-images.githubusercontent.com/48917101/205256783-ae077de5-228f-41bb-b68a-d60976139057.png)

### Pins

MPU6050| Arduino
---|---|
VCC|5V|
GND|GND
SCL|A5
SDA|A4
INT|D2


HC-06|Arduino
---|---
VCC|5V
GND|GND
TXD|D8
RXD|D7


TOF10120| RaspberryPi
---|---|
GND|GND|
VCC|5V
RXD|X
TXD|X
SDL|A4
SCL|A5


MFRC522	|	RaspberryPi
---|---
SDA		|GPIO8
SCK		|GPIO11
MOSI	|GPIO10
MISO	|GPIO9
IRQ		|None
GND		|GND
RST		|GPIO25
3.3V	|	3.3V


----
### Setup


#### RaspberryPi


SPI-Py : https://github.com/lthiery/SPI-Py


    sudo apt-get update 
    sudo apt-get install python3-smbus
    sudo apt-get install socket
    
    sudo apt-get install python-dev
    sudo apt-get install python-rpi.gpio

#### Arduino

MPU6050 Library : https://github.com/ElectronicCats/mpu6050

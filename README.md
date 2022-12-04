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

## DEMO


### 1.회원가입
Firebase_auth를 사용한 회원가입


<img src="https://user-images.githubusercontent.com/48917101/205510327-a08ec8de-946a-46f7-b06d-ded1e8d35ef4.png" width="400" height="600"/>


### 2.로그인


<img src="https://user-images.githubusercontent.com/48917101/205510318-3525e914-6158-4bfc-9d98-a2d607b29fd6.png" width="400" height="600"/>


### 3.헬스 달력
<img src="https://user-images.githubusercontent.com/48917101/205510323-9ea1b9f2-a296-4ff5-8d06-dbeac511eedd.png" width="400" height="600"/>



### 4. 다른 운동 기구 기록 예시
<img src="https://user-images.githubusercontent.com/48917101/205510325-458008d6-c212-42e0-bb29-d13bb00f8404.png" width="400" height="600"/>


### 5. 칼로리 소비량 예시
<img src="https://user-images.githubusercontent.com/48917101/205510324-cbf5cfbe-ff92-4356-b47a-f54f9323df0e.png" width="400" height="600"/>


### 6. 운동 데이터
<img src="https://user-images.githubusercontent.com/48917101/205510326-5688f9f1-06b5-4319-b2c7-aaa5550b9ad1.png" width="400" height="600"/>



### 7. 기울기 측정 시각화
<img src="https://user-images.githubusercontent.com/48917101/205510794-60e66358-8fab-4576-a6ce-fbe191e43c4b.png" width="400" height="600"/>


### 데모영상


![ezgif com-gif-maker](https://user-images.githubusercontent.com/48917101/205511796-38199e8b-6dd8-4641-a776-a8ef66f0cb09.gif)


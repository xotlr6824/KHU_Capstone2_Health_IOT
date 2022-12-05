# 주제

## IOT Health Training 장비 개발


가속도, 자이로 센서 / 거리센서 등을 활용하여 헬스 정보를 기록하는 IOT 장비를 개발한다.


운동 중, 후에 헬스 루틴을 직접 기록하는 번거로움을 줄이는 것을 목적으로 한다.


또한 사용자에게 쉽게 정보 전달을 하기 위해 어플리케이션을 통해 제공한다.


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


#### RaspberryPi


    sudo apt-get update 
    sudo apt-get install python3-smbus
    sudo apt-get install socket
    
    sudo apt-get install python-dev
    sudo apt-get install python-rpi.gpio

#### Flutter / Firebase 초기 설정


https://firebase.google.com/docs/flutter/setup?platform=ios


# DEMO


## 측정 방법


#### 랫 풀 다운 머신


<img src="https://user-images.githubusercontent.com/48917101/205532329-e2b79c08-fa2f-4ea2-99ee-080025a3d5da.png" width="400" height="600"/>


랫풀 다운 머신을 선정하여 실험하였다.


#### 부착 사진


<img src="https://user-images.githubusercontent.com/48917101/205531295-90983499-41aa-46ce-9b16-efb084d9716d.jpg" width="400" height="600"/>


봉에 아두이노와 HC-06, mpu6050을 부착한 사진이다.


<img src="https://user-images.githubusercontent.com/48917101/205531301-cf95e8da-e2c2-4cb3-bff8-0772a183083d.JPG" width="400" height="600"/>


라즈베리파이와 TOF10120, MFRC522를 부착한 사진이다.



### 데모영상



1. rfid 리더기에 카드 태깅 후 운동 데이터를 받아오는 모습


![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/48917101/205512035-b13b08e8-ab08-4ab0-bea3-6080e2d03199.gif)



2. 한 세트 종료 후 카드 체크하여 다음 세트 측정 하는 모습


![ezgif com-gif-maker (3)](https://user-images.githubusercontent.com/48917101/205512218-14dfe772-86e1-40ff-a9fa-cc7754f277cb.gif)


3. 10초동안 동작이 없으면 세트가 종료되고 firestore에 저장된 데이터의 모습


![ezgif com-gif-maker (4)](https://user-images.githubusercontent.com/48917101/205512440-ab15c900-6e67-4b95-a303-d97aeda3bf81.gif)


4. 어플리케이션과 연동된 모습


![ezgif com-gif-maker (5)](https://user-images.githubusercontent.com/48917101/205512968-66a00c35-e835-47f0-a602-7f7cb4cdf951.gif)


## 사용자 화면


### 1.회원가입
Firebase_auth를 사용한 회원가입


<img src="https://user-images.githubusercontent.com/48917101/205510327-a08ec8de-946a-46f7-b06d-ded1e8d35ef4.png" width="400" height="600"/>


### 2.로그인


<img src="https://user-images.githubusercontent.com/48917101/205510318-3525e914-6158-4bfc-9d98-a2d607b29fd6.png" width="400" height="600"/>


### 3.헬스 달력


<img src="https://user-images.githubusercontent.com/48917101/205510323-9ea1b9f2-a296-4ff5-8d06-dbeac511eedd.png" width="400" height="600"/>


운동을 한 날짜를 클릭하면 운동한 기구들이 나온다.


### 4. 다른 운동 기구 기록 예시


<img src="https://user-images.githubusercontent.com/48917101/205510325-458008d6-c212-42e0-bb29-d13bb00f8404.png" width="400" height="600"/>


다른 여러 기구를 했을 때 나타나는 예시이다.


### 5. 칼로리 소비량 예시


<img src="https://user-images.githubusercontent.com/48917101/205510324-cbf5cfbe-ff92-4356-b47a-f54f9323df0e.png" width="400" height="600"/>


주간 칼로리 소비량을 예시로 든 차트이다.


### 6. 운동 데이터


<img src="https://user-images.githubusercontent.com/48917101/205510326-5688f9f1-06b5-4319-b2c7-aaa5550b9ad1.png" width="400" height="600"/>


측정한 데이터를 나타낸 화면이다.


### 7. 기울기 측정 시각화


<img src="https://user-images.githubusercontent.com/48917101/205510794-60e66358-8fab-4576-a6ce-fbe191e43c4b.png" width="400" height="600"/>


mpu6050을 통해 얻어낸 기울기 데이터를 시각화 한 차트이다.


y축 위에서 아래로 시간의 흐름, x축 좌/우는 쏠림 정도를 나타낸다.




5. 어플리케이션 전체 모습


![ezgif com-gif-maker](https://user-images.githubusercontent.com/48917101/205511796-38199e8b-6dd8-4641-a776-a8ef66f0cb09.gif)

### 참고문헌

SPI-Py : https://github.com/lthiery/SPI-Py


MPU6050 Library : https://github.com/ElectronicCats/mpu6050


Flutter pakage : https://pub.dev/


Firebase docs : https://firebase.google.com/docs/

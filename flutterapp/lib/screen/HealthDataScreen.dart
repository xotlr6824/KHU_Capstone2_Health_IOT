import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../chart/BalanceChart.dart';

class HealthDataScreen extends StatefulWidget {
  const HealthDataScreen({super.key});

  @override
  State<HealthDataScreen> createState() => _HealthDataScreenState();
}

class _HealthDataScreenState extends State<HealthDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 54, 53, 52),
      appBar: AppBar(
        title: Text('헬스'),
        backgroundColor: Color.fromARGB(255, 54, 53, 52),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 380,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('/users/user4/record/20221205/machine')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  DateTime now = DateTime.now();
                  return Center(
                    child: Text(
                      '기록 없음',
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final total = snapshot.data!.docs;
                var total_time = total[0].get('total_time');
                var result = total_time.toStringAsFixed(2);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: Text(
                        '총 운동 시간 : ${result} 초',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            width: 380,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      '/users/user4/record/20221205/machine/LatPullDown/sets')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  DateTime now = DateTime.now();
                  return Center(
                    child: Text(
                      '기록 없음',
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final total = snapshot.data!.size;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: Text(
                        '총 세트 수 : ${total} 회',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 500,
            width: 400,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        '/users/user4/record/${'20221205'}/machine/LatPullDown/sets')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        '기록 없음',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    );
                  }
                  final docss = snapshot.data!.docs;

                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    color: Colors.grey[600],
                    child: ListView.builder(
                        itemCount: docss.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset.zero,
                                                blurStyle: BlurStyle.normal,
                                                spreadRadius: 3.0,
                                              ),
                                            ]),
                                        child: Row(children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 30),
                                                width: 100,
                                                height: 60,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  'Set ${index + 1}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 50,
                                                margin: const EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color.fromARGB(
                                                      255, 54, 53, 52),
                                                ),
                                                child: IconButton(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  icon: Icon(Icons.bar_chart),
                                                  iconSize: 30,
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return LineChartSample2();
                                                    }));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color.fromARGB(
                                                      255, 45, 44, 44),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        '반복횟수',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Text(
                                                        '세트 시간',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        '중량',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color.fromARGB(
                                                      255, 45, 44, 44),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        '${docss[index].get('repetition')}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Text(
                                                        '${docss[index].get('set_time')}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      width: 100,
                                                      height: 30,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        '${docss[index].get('weight')}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 45, 44, 44),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      )
                                    ],
                                  )
                                ],
                              ));
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

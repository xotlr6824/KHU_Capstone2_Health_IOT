import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/chart/Barchart.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/screen/HealthDataScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chart/Barchart.dart';
import 'HealthDataScreen.dart';

class IOT_Screen extends StatefulWidget {
  const IOT_Screen({super.key});

  @override
  State<IOT_Screen> createState() => _IOT_ScreenState();
}

class _IOT_ScreenState extends State<IOT_Screen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final auth = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 54, 53, 52),
          title: Text('곽태식'),
          bottom: TabBar(tabs: [
            Tab(
              text: '헬스 달력',
            ),
            Tab(text: '칼로리 소비량')
          ]),
        ),
        //
        body: TabBarView(
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final docss = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docss.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          child: Stack(children: [
                            SizedBox(
                              height: 30,
                            ),
                            Positioned(
                              child: Container(
                                height: 700,
                                width: 400,
                                color: Color.fromARGB(255, 54, 53, 52),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 380,
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(1),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10, spreadRadius: 5)
                                        ],
                                      ),
                                      child: TableCalendar<Event>(
                                        firstDay: kFirstDay,
                                        lastDay: kLastDay,
                                        focusedDay: _focusedDay,
                                        selectedDayPredicate: (day) =>
                                            isSameDay(_selectedDay, day),
                                        rangeStartDay: _rangeStart,
                                        rangeEndDay: _rangeEnd,
                                        calendarFormat: _calendarFormat,
                                        rangeSelectionMode: _rangeSelectionMode,
                                        eventLoader: _getEventsForDay,
                                        startingDayOfWeek:
                                            StartingDayOfWeek.monday,
                                        calendarStyle: CalendarStyle(
                                          // Use `CalendarStyle` to customize the UI
                                          outsideDaysVisible: false,
                                        ),
                                        onDaySelected: _onDaySelected,
                                        onRangeSelected: _onRangeSelected,
                                        onFormatChanged: (format) {
                                          if (_calendarFormat != format) {
                                            setState(() {
                                              _calendarFormat = format;
                                            });
                                          }
                                        },
                                        onPageChanged: (focusedDay) {
                                          _focusedDay = focusedDay;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        width: 380,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(1),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10, spreadRadius: 5)
                                          ],
                                        ),
                                        child:
                                            ValueListenableBuilder<List<Event>>(
                                          valueListenable: _selectedEvents,
                                          builder: (context, value, _) {
                                            return Container(
                                              height: 100,
                                              child: ListView.builder(
                                                itemCount: value.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      color: Colors.black,
                                                    ),
                                                    child: ListTile(
                                                      onTap: () => print(
                                                          '${value[index]}'),
                                                      title: TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return HealthDataScreen();
                                                          }));
                                                        },
                                                        child: Text(
                                                          '${value[index]}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            WeekBarChart(),
          ],
        ),
      ),
    );
  }
}

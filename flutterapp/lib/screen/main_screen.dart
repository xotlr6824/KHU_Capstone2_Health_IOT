import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/screen/iot_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final auth = FirebaseAuth.instance;

  bool isSignUp = true;
  final formkey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  void TryValidation() {
    final isValid = formkey.currentState!.validate();
    if (isValid) {
      formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 54, 53, 52),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              //배경
              top: 0,
              child: Container(
                height: 850,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('image/12345.jpg'), fit: BoxFit.fill),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 180, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.orange,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 5.0,
                                    color: Color.fromARGB(255, 30, 28, 28),
                                  ),
                                ]),
                            children: [
                              TextSpan(
                                text: ' IOT Application',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 25,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(3.0, 3.0),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(255, 30, 28, 28),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                      const Text(
                        'create by sik.sik',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 5.0,
                              color: Color.fromARGB(255, 30, 28, 28),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              //텍스트폼필드
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 300,
              width: 400,
              left: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20.0),
                height: isSignUp ? 300 : 230,
                width: MediaQuery.of(context).size.width - 100,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ],
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUp = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignUp
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.8)),
                            ),
                            Container(
                              height: 2,
                              width: 55,
                              color: !isSignUp
                                  ? Colors.orange
                                  : Colors.orange.withOpacity(0.8),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUp = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignUp
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.8)),
                            ),
                            Container(
                              height: 2,
                              width: 55,
                              color: isSignUp
                                  ? Colors.orange
                                  : Colors.orange.withOpacity(0.8),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSignUp)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              //ID
                              key: ValueKey(1),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 4) {
                                  return 'Please enter at least 4 chareacters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userName = value!;
                              },
                              onChanged: (value) {
                                userName = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'User name',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              key: ValueKey(2),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a value email address.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userEmail = value!;
                              },
                              onChanged: (value) {
                                userEmail = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'email',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              key: ValueKey(3),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Password must be at least 7 characters long.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userPassword = value!;
                              },
                              onChanged: (value) {
                                userPassword = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'password',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!isSignUp)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              //ID
                              key: ValueKey(4),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a value email address.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userEmail = value!;
                              },
                              onChanged: (value) {
                                userEmail = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'User name',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              key: ValueKey(5),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Password must be at least 7 characters long.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userPassword = value!;
                              },
                              onChanged: (value) {
                                userPassword = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                hintText: 'password',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ]),
              ),
            ),
            Positioned(
              //전송버튼
              bottom: 130,
              right: 80,
              left: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isSignUp) {
                    TryValidation();
                    try {
                      final newUser = await auth.createUserWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      );
                      if (newUser.user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return IOT_Screen();
                            },
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please check your email or password'),
                        backgroundColor: Colors.blue,
                      ));
                    }
                  }
                  if (!isSignUp) {
                    TryValidation();
                    try {
                      final newUser = await auth.signInWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      );
                      if (newUser.user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return IOT_Screen();
                            },
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isSignUp ? 'sign up' : 'sign in',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.withOpacity(0.8)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 125,
              right: 0,
              left: 0,
              child: Column(children: [
                Text(
                  'or sign up with ',
                  style: TextStyle(color: Colors.orange.withOpacity(0.9)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(155, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.orange),
                  icon: Icon(Icons.add),
                  label: Text('Google'),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

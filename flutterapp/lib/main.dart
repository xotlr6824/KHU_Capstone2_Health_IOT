import 'package:flutter/material.dart';
import 'package:flutterapp/screen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IOT",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginSignUpScreen(),
    );
  }
}

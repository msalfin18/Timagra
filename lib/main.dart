import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/firebase_options.dart';// Your home screen
import 'package:timagra_new/view/homepage.dart';
import 'package:timagra_new/view/registration/login.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check login status before running the app
  bool isLoggedIn = await checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> checkLoginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timagra New',
      theme: ThemeData(
        platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
        primaryColor: Color.fromARGB(255, 206, 206, 206),
        cardColor: Colors.white,
        dividerColor: Color.fromARGB(255, 206, 206, 206),
        useMaterial3: true,
      ),
      home: isLoggedIn ? Homepage() : SignInPage(),
    );
  }
}

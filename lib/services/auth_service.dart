import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/view/homepage.dart';
import 'package:timagra_new/view/registration/login.dart';
import 'package:http/http.dart'  as http;

class AuthService {

Future<void> signup({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    // Firebase Authentication: Create user
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get user details
    User? user = userCredential.user;
    if (user != null) {
      String userId = user.uid;
      String userEmail = user.email ?? "No email";

      // Send user data to database API
      String url = "http://192.168.29.50/thinkay4_marbleshop/API/add_user_login.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "userid": userId,
          "email": userEmail,
        },
      );

      if (response.statusCode == 200) {
        // Save login status
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Userid', userId);
        await prefs.setString('Useremail', userEmail);
        await prefs.setBool('isLoggedIn', true);

        Fluttertoast.showToast(msg: 'Signup Successful!');

        // Navigate to Homepage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: "Registration Failed. Please try again.");
      }
    }
  } on FirebaseAuthException catch (e) {
    String message = '';

    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'Email already exists!';
    } else {
      message = 'An unexpected error occurred.';
    }

    Fluttertoast.showToast(msg: message);
  } catch (e) {
    Fluttertoast.showToast(msg: 'Error: $e');
  }
}


Future<void> signin({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    print('Trying to sign in...');
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get user details
    User? user = userCredential.user;
    if (user != null) {
      String userId = user.uid;
      String userEmail = user.email ?? "No email";
      print(user);

      print("User ID: $userId");
      print("Email: $userEmail");
        
           final SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setString('Userid', userId);
             await prefs.setString('Useremail', userEmail);

    }

    // Save login status
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
 

    Fluttertoast.showToast(msg: 'Signin Successful!');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (route) => false,
    );
  } on FirebaseAuthException catch (e) {
    print(e);
    Fluttertoast.showToast(msg: 'User not found or wrong password!');
  } catch (e) {
    print(e.toString());
  }
}


  // Logout function
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Clear login status
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Fluttertoast.showToast(msg: 'Signed out successfully!');

    // Navigate to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
      (route) => false,
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'register.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.0),
            ListTile(),
            // logo
            Image.asset("images/nelam.png"),
            SizedBox(height: 40.0),
            // button
            InkWell(
              onTap: () {
              Get.to(LoginPage(),transition: Transition.rightToLeft);
              },
              child: Container(
                height: 55.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 26, 69, 145),
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                 Get.to(RegisterPage(),transition: Transition.rightToLeft);
              },
              child: Container(
                height: 55.0, 
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 26, 69, 145),
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            // end
          ],
        ),
      ),
    );
  }
}

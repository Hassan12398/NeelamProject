// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/frontend/screens/mainbottombar.dart';
import 'package:nelaamproject/frontend/screens/resetPassword.dart';

import '../../backend/auth/authFunctions.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  bool obsecure = true;
  bool isloading = false;

  // Future login() async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   AuthFunctions.instance.loginUser(emailc.text, passwordc.text);
  // }

  @override
  void dispose() {
    emailc.dispose();
    passwordc.dispose();

    super.dispose();
  }

  void _togglepassword() {
    if (obsecure == true) {
      setState(() {
        obsecure = false;
      });
    } else {
      setState(() {
        obsecure = true;
      });
    }
  }

  String error = '';
  String Perror = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
      // appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // for logo
            Image.asset("images/nelam.png"),
            // fields + button
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // email
                      Text(
                        "E-MAIL ADDRESS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        height: 40.0,
                        width: 250.0,
                        child: TextField(
                          controller: emailc,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      error.isEmpty
                          ? Container()
                          : Text(error,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                      // password
                      SizedBox(height: 12.0),
                      Text(
                        "PASSWORD",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      SizedBox(
                        height: 40.0,
                        width: 250.0,
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          obscureText: obsecure,
                          controller: passwordc,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: _togglepassword,
                                child: obsecure
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.lightBlue.shade900,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.lightBlue.shade900,
                                      )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Perror.isEmpty
                          ? Container()
                          : Text(Perror,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "RESET PASSWORD",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  // button
                  GestureDetector(
                    onTap: () async {
                      String result = await AuthFunction()
                          .loginUser(emailc.text, passwordc.text, context);

                      if (result == 'error-user') {
                        setState(() {
                          error = 'Email Not Found!';
                          Perror = '';
                        });
                      } else if (result == 'error-pass') {
                        setState(() {
                          Perror = 'Wrong Password!';
                          error = '';
                        });
                      } else if (result == 'fields-error') {
                        error = "Email is Empty";
                        Perror = "Password is Empty";
                        setState(() {});
                      }
                      if (result == 'invalid-email') {
                        setState(() {
                          error = '';
                          Perror = '';
                          error = "Your Email Is Badly Formatted!";
                        });
                      }
                      if (result == '') {
                        setState(() {
                          isloading = true;
                        });
                        await Future.delayed(Duration(milliseconds: 3000)).then(
                            (value) => Get.to(MainBottomBar(),
                                transition: Transition.rightToLeft));
                      }
                    },
                    child: Container(
                      height: 55.0,
                      width: 150.0,
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
                        child: isloading == false
                            ? Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 26, 69, 145),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(RegisterPage(), transition: Transition.rightToLeft);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CREATE A NEW ACCOUNT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    InkWell(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // end
    );
  }
}

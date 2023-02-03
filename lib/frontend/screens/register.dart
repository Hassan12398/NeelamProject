// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/backend/auth/authFunctions.dart';

import 'mainbottombar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userc = TextEditingController();
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  TextEditingController cpassc = TextEditingController();
  bool obsecure = true;
  bool obsecure1 = true;
  @override
  void dispose() {
    emailc.dispose();
    passwordc.dispose();
    cpassc.dispose();
    userc.dispose();
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

  void _togglepassword1() {
    if (obsecure1 == true) {
      setState(() {
        obsecure1 = false;
      });
    } else {
      setState(() {
        obsecure1 = true;
      });
    }
  }

  bool isLoading = false;
  String error = '';
  String Eerror = '';
  String Perror = '';
  String cPerror = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
      bottomNavigationBar: InkWell(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          if (userc.text.length <= 5) {
            setState(() {
              error = 'Username Should be at least 6 Characters!';
              isLoading = false;
            });
          } else if (passwordc.text != cpassc.text) {
            setState(() {
              cPerror = 'Password and Confirm Password didn\'t match.';
              isLoading = false;
            });
          } else {
            String result = await AuthFunction().Signup(
                emailc.text,
                passwordc.text,
                userc.text,
                // _image!
                context);
            print(result);
            if (result == 'password-error') {
              setState(() {
                isLoading = false;
                error = '';
                Eerror = '';
                Perror = "Password Should be at least 6 Characters!";
              });
            }
            if (result == 'email-error') {
              setState(() {
                error = '';
                isLoading = false;
                Perror = '';
                Eerror = "Email is Already in Used By Another Account!";
              });
            }
            if (result == 'fields-error') {
              setState(() {
                // error = "Username is Empty";
                isLoading = false;
                Eerror = "Email is Empty";
                Perror = "Password is Empty";
              });
            }
            if (result == 'invalid-email') {
              setState(() {
                isLoading = false;
                error = '';
                Perror = '';
                Eerror = "Your Email Is Badly Formatted!";
              });
            }
            if (userc.text.length <= 5) {
              setState(() {
                isLoading = false;
                error = 'Username Should be 6 Characters!';
              });
            }
            if (result == '' && userc.text.length >= 5) {
              setState(() {
                isLoading = true;
              });
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MainBottomBar();
              }));
            }
          }
        },
        child: Container(
          height: 55.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Center(
            child: isLoading == false
                ? Text(
                    "Sign up",
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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // logo
                Image.asset("images/nelam.png", height: 200.0),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    // fields
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // name
                        Text(
                          "FULL NAME",
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
                            controller: userc,
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
                        SizedBox(height: 12.0),
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
                            textInputAction: TextInputAction.next,
                            controller: emailc,
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
                        Eerror.isEmpty
                            ? Container()
                            : Text(Eerror,
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
                            obscureText: obsecure,
                            textInputAction: TextInputAction.next,
                            controller: passwordc,
                            decoration: InputDecoration(
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
                              isDense: true,
                              filled: true,
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
                        // confirm
                        SizedBox(height: 12.0),
                        Text(
                          "CONFIRM PASSWORD",
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
                            controller: cpassc,
                            obscureText: obsecure1,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              suffixIcon: GestureDetector(
                                  onTap: _togglepassword1,
                                  child: obsecure1
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
                      ],
                    ),
                    cPerror.isEmpty
                        ? Container()
                        : Text(cPerror,
                            style: TextStyle(
                              color: Colors.red,
                            )),
                    SizedBox(height: 30.0),
                    // svg social
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SvgPicture.asset("images/facebook.svg", height: 70.0),
                        GestureDetector(
                          onTap: () async {
                            bool res =
                                await AuthFunction().signInWithGoogle(context);
                            if (res) {
                              Get.to(MainBottomBar(),
                                  transition: Transition.rightToLeft);
                            }
                          },
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(15),
                            // shape: CircleBorder(side: BorderSide.none),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: SvgPicture.asset("images/google.svg",
                                    height: 40.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.0),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (_) => MainBottomBar(),
                    //         ),
                    //       );
                    //     },
                    //     child: Container(
                    //       height: 55.0,
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(12.0),
                    //           topRight: Radius.circular(12.0),
                    //         ),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           "Sign up",
                    //           style: TextStyle(
                    //             color: Color.fromARGB(255, 26, 69, 145),
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 18.0,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // end
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/Widgets/snackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailc = TextEditingController();
  String checking = "";
  bool isloading = false;
  Future resetPass(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 120,
                child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    child: Icon(
                      Icons.check,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Reset Password Link sent to your Email.Please Check your Email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      setState(() {
        checking = e.code;
      });

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 110,
                child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    e.message!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // for logo
            Image.asset("images/nelam.png"),
            SizedBox(height: 20),
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
            Container(width: double.infinity),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () async {
                await resetPass(emailc.text);

                // if (checking == "") {
                //   setState(() {
                //     isloading = true;
                //   });
                //   Navigator.pop(context);
                //   Showsnackbar(
                //       context, 'Operation Complete ! please checkout email');
                // } else {
                //   print(checking);
                // }
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
                          "RESET",
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
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/backend/notifications/function.dart';
import 'package:nelaamproject/frontend/message/message.dart';

class rating_screen extends StatefulWidget {
  String uid;
  rating_screen({super.key, required this.uid});

  @override
  State<rating_screen> createState() => _rating_screenState();
}

class _rating_screenState extends State<rating_screen> {
  var userData = {};
  var userData1 = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
    getData1();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      setState(() {
        userData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  getData1() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData1 = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  int rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rating'),
        ),
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 27),
                    width: double.infinity,
                    height: 280.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 12, 77, 131),
                        width: 3.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 84, 83, 83),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(2, 4),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Rate To Seller',
                          style: TextStyle(
                            color: Color.fromARGB(255, 30, 76, 106),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(userData['profileUrl']),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              userData['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: RatingBar.builder(
                            // rating: 3.5,
                            onRatingUpdate: (value) {
                              setState(() {
                                rate = value.toInt();
                                log(rate.toString());
                              });
                            },

                            itemBuilder: (context, index) => Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 55.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            if (rate > 0) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ));
                              if (rate == 1) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  '1 star': FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid]),
                                });
                              } else if (rate == 2) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  '2 star': FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid]),
                                });
                              } else if (rate == 3) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  '3 star': FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid]),
                                });
                              } else if (rate == 4) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  '4 star': FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid]),
                                });
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.uid)
                                    .update({
                                  '5 star': FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid]),
                                });
                              }
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('Chatrooms')
                                  .doc(widget.uid)
                                  .update({
                                'lastMessage': '',
                              });
                              LocalNotificationService.sendPushMessage(
                                  '${userData1['username']} gave you $rate star rating',
                                  'Rating',
                                  userData['token']);
                              Get.back();
                              Get.to(message_screen(uid: widget.uid),
                                  transition: Transition.rightToLeft);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: rate == 0
                                  ? Colors.grey
                                  : Color.fromARGB(255, 30, 76, 106),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(3, 4),
                                  blurRadius: 7,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Message',
                                style: TextStyle(
                                  color:
                                      rate == 0 ? Colors.black : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]));
  }
}

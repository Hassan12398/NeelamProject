// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nelaamproject/frontend/message/message.dart';
import 'package:nelaamproject/frontend/screens/rating_screen.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  String search = '';
  bool show = false;
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // UploadTask? uploa;
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    String dateToday(DateTime Time) {
      String time = '';
      final dateToCheck = Time;
      final aDate =
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
      if (aDate == today) {
        return time = DateFormat.jm().format(Time);
      } else {
        return time = DateFormat.yMd().format(Time);
      }
      return time;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Inbox',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                // controller: search,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Color.fromARGB(255, 229, 223, 126),
                  filled: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onChanged: (v) {
                  if (v.isNotEmpty) {
                    setState(() {
                      show = true;
                    });
                  } else {
                    setState(() {
                      show = false;
                    });
                  }
                  setState(() {
                    search = v;
                  });
                },
              ),
            ),
            show == true
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Chatrooms')
                        .where("username", isGreaterThanOrEqualTo: search)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          dragStartBehavior: DragStartBehavior.start,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs[index].data();
                            // CollectionReference<Map<String, dynamic>> collection;
                            return GestureDetector(
                              onTap: () {
                                if (snap['lastMessage'] == 'bid') {
                                  Get.to(
                                      rating_screen(
                                        uid: snap['uid'],
                                      ),
                                      transition: Transition.rightToLeft);
                                } else {
                                  Get.to(
                                      message_screen(
                                        uid: snap['uid'],
                                      ),
                                      transition: Transition.rightToLeft);
                                }
                              },
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade900,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snap['profileImage']))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                135,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snap['username'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    dateToday(
                                                            snap['time']
                                                                .toDate())
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: snap['lastMessage'] ==
                                                                'bid'
                                                            ? Color.fromARGB(
                                                                255,
                                                                30,
                                                                76,
                                                                106)
                                                            : snap['lastMessage'] ==
                                                                    'buy now'
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        30,
                                                                        76,
                                                                        106)
                                                                : Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13)),
                                              ],
                                            ),
                                          ),
                                          snap['lastMessage'] == 'bid'
                                              ? Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      138,
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'I Accepted your bid request!',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                30, 76, 106),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : snap['lastMessage'] == 'buy now'
                                                  ? Container(
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              138,
                                                      color: Colors.transparent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'I Wants to buy your product!',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    30,
                                                                    76,
                                                                    106),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                            ;
                          });
                    })
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Chatrooms')
                        .orderBy(
                          'time',
                          descending: true,
                        )
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          dragStartBehavior: DragStartBehavior.start,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs[index].data();
                            // CollectionReference<Map<String, dynamic>> collection;
                            return GestureDetector(
                              onTap: () {
                                if (snap['lastMessage'] == 'bid') {
                                  Get.to(
                                      rating_screen(
                                        uid: snap['uid'],
                                      ),
                                      transition: Transition.rightToLeft);
                                } else {
                                  Get.to(
                                      message_screen(
                                        uid: snap['uid'],
                                      ),
                                      transition: Transition.rightToLeft);
                                }
                              },
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade900,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snap['profileImage']))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                135,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snap['username'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    dateToday(
                                                            snap['time']
                                                                .toDate())
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: snap['lastMessage'] ==
                                                                'bid'
                                                            ? Color.fromARGB(
                                                                255,
                                                                30,
                                                                76,
                                                                106)
                                                            : snap['lastMessage'] ==
                                                                    'buy now'
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        30,
                                                                        76,
                                                                        106)
                                                                : Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13)),
                                              ],
                                            ),
                                          ),
                                          snap['lastMessage'] == 'bid'
                                              ? Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      138,
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'I Accepted your bid request!',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                30, 76, 106),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : snap['lastMessage'] == 'buy now'
                                                  ? Container(
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              138,
                                                      color: Colors.transparent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'I want to buy your product!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    30,
                                                                    76,
                                                                    106),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                            ;
                          });
                    })
          ],
        ),
      ),
    );
  }
}

class chat extends StatelessWidget {
  const chat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.lightBlue.shade900,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://irisvision.com/wp-content/uploads/2019/01/no-profile-1-1200x1200.png'))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Column(
              children: [
                Text(
                  'Hassan Butt',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

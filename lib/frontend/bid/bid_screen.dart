import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

class bid_screen extends StatefulWidget {
  int price;
  int minBid;
  String postId;
  bid_screen(
      {super.key,
      required this.price,
      required this.minBid,
      required this.postId});

  @override
  State<bid_screen> createState() => _bid_screenState();
}

class _bid_screenState extends State<bid_screen> {
  TextEditingController bid = TextEditingController(text: '20000');
  int price = 0;
  @override
  void initState() {
    // TODO: implement initState
    price = widget.price;
    getData();
    super.initState();
  }

  var userData = {};
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  bool error = false;
  @override
  Widget build(BuildContext context) {
    //  int price = widget.price;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Bid It',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 27),
              width: double.infinity,
              height: 260.0,
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
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'How much you want to Bid for this Product',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 12, 77, 131),
                        width: 3.0,
                      ),
                    ),
                    child: Row(children: [
                      Container(
                        height: 70,
                        width: 150,
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  '${price}',
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (price < widget.price) {
                                if (price < 100) {
                                  setState(() {
                                    price = price + 10;
                                    error = false;
                                  });
                                } else if (price < 1000) {
                                  setState(() {
                                    price = price + 50;
                                    error = false;
                                  });
                                } else if (price < 5000) {
                                  setState(() {
                                    price = price + 500;
                                    error = false;
                                  });
                                } else if (price < 15000) {
                                  setState(() {
                                    price = price + 1000;
                                    error = false;
                                  });
                                } else if (price < 25000) {
                                  setState(() {
                                    price = price + 1500;
                                    error = false;
                                  });
                                } else if (price < 35000) {
                                  setState(() {
                                    price = price + 2000;
                                    error = false;
                                  });
                                } else {
                                  setState(() {
                                    price = price + 2500;
                                    error = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  error = false;
                                });
                              }
                            },
                            child: Container(
                              height: 32,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: GestureDetector(
                                  //   onTap: (){
                                  //       setState(() {
                                  //       price = price +500;
                                  // });
                                  // },
                                  child: Center(
                                      child:
                                          Icon(Icons.arrow_drop_up, size: 40))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (price > widget.minBid) {
                                if (price < 100) {
                                  setState(() {
                                    price = price - 10;
                                    error = false;
                                  });
                                } else if (price < 1000) {
                                  setState(() {
                                    price = price - 50;
                                    error = false;
                                  });
                                } else if (price < 5000) {
                                  setState(() {
                                    price = price - 500;
                                    error = false;
                                  });
                                } else if (price < 15000) {
                                  setState(() {
                                    price = price - 1000;
                                    error = false;
                                  });
                                } else if (price < 25000) {
                                  setState(() {
                                    price = price - 1500;
                                    error = false;
                                  });
                                } else if (price < 35000) {
                                  setState(() {
                                    price = price - 2000;
                                    error = false;
                                  });
                                } else {
                                  setState(() {
                                    price = price - 2500;
                                    error = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  error = true;
                                });
                              }
                            },
                            child: Container(
                              height: 32,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                  child: Icon(Icons.arrow_drop_down, size: 40)),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  error
                      ? Text(
                          '*Bid should not be less then ${widget.minBid}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: () async {
                          if (widget.price == price) {
                            Get.snackbar(
                                'Bid Error', 'You cannot bid at same price',
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.symmetric(
                                    vertical: 80, horizontal: 10),
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                icon: Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                forwardAnimationCurve: Curves.bounceIn,
                                overlayBlur: 1,
                                duration: Duration(seconds: 2));
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                      content: Container(
                                          height: 180,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.error_outlined,
                                                  color: Colors.red,
                                                  size: 55,
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                    'Are you sure for Bid on this Product?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        height: 43,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                        child: Center(
                                                          child: Text('Cancel',
                                                              style: TextStyle(
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        var id = Uuid().v1();
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Products')
                                                            .doc(widget.postId)
                                                            .collection('bids')
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .set({
                                                          "accepted": false,
                                                          "bid price": price,
                                                          "imageUrl": userData[
                                                              'profileUrl'],
                                                          "maximum price":
                                                              widget.price,
                                                          "postId": id,
                                                          "product Id":
                                                              widget.postId,
                                                          "uid": FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                          "username": userData[
                                                              'username'],
                                                        });
                                                        List bid = [
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                        ];
                                                        Get.back();
                                                        Get.back();
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Products')
                                                            .doc(widget.postId)
                                                            .update({
                                                          "bids": FieldValue
                                                              .arrayUnion(bid),
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 43,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                        child: Center(
                                                          child: Text('Bid',
                                                              style: TextStyle(
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ])));
                                });
                          }
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Color.fromARGB(255, 30, 76, 106),
                          child: Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      CupertinoButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

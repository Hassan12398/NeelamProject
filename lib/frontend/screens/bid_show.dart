import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/Widgets/snackbar.dart';
import 'package:nelaamproject/backend/notifications/function.dart';
import 'package:uuid/uuid.dart';

class bid_Show extends StatefulWidget {
  String postId;
  String product;
  String uid;
  List bid;
  String imageUrl;
  bid_Show(
      {super.key,
      required this.postId,
      required this.bid,
      required this.uid,
      required this.imageUrl,
      required this.product});

  @override
  State<bid_Show> createState() => _bid_ShowState();
}

class _bid_ShowState extends State<bid_Show> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    getData1();
    super.initState();
  }

  var userData = {};
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

  var userData1 = {};
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

  CreateChatRoom(String uid, name1, name2, String prof1, String prof2,
      String product, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(uid)
          .set({
        'uid': uid,
        'lastMessage': '',
        'read': false,
        'username': name2,
        'profileImage': prof2,
        'time': DateTime.now(),
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'username': name1,
        'read': false,
        'lastMessage': '',
        'profileImage': prof1,
        'time': DateTime.now(),
      });

      String postId = Uuid().v1();
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(uid)
          .collection('messages')
          .doc(postId)
          .set({
        'message':
            'Hi you send me bid on my $product product and i accepted your bid request if you want to buy my product you can contact me',
        'chatId': uid,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'name': name1,
        'read': false,
        'type': 'text',
        'time': DateTime.now(),
        'postId': postId,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(postId)
          .set({
        'message':
            'Hi you send me bid on my $product product and i accepted your bid request if you want to buy my product you can contact me',
        'chatId': uid,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'read': false,
        'name': name1,
        'type': 'text',
        'time': DateTime.now(),
        'postId': postId,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(uid)
          .update({'lastMessage': ''});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'lastMessage': 'bid'});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(uid)
          .update({'time': DateTime.now()});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'time': DateTime.now()});
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bids'),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Products')
                  .doc(widget.postId)
                  .collection('bids')
                  .orderBy('bid price', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var snap = snapshot.data!.docs[index].data();
                      return Container(
                        height: 70,
                        color: Color.fromARGB(255, 221, 220, 220),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 8.0),
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(snap['imageUrl']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          snap['username'].toString().length < 8
                                              ? snap['username'].toString()
                                              : snap['username']
                                                  .toString()
                                                  .replaceRange(
                                                      6,
                                                      snap['username']
                                                          .toString()
                                                          .length,
                                                      '...'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${snap['bid price']}.Rs',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ));
                                    CreateChatRoom(
                                        userData['uid'],
                                        userData1['username'],
                                        userData['username'],
                                        userData1['profileUrl'],
                                        userData['profileUrl'],
                                        widget.product,
                                        context);
                                    await FirebaseFirestore.instance
                                        .collection('Products')
                                        .doc(widget.postId)
                                        .update({
                                      'bids':
                                          FieldValue.arrayRemove([snap['uid']])
                                    });
                                    for (var i = 0;
                                        i < widget.bid.length;
                                        i++) {
                                      FirebaseFirestore.instance
                                          .collection("Products")
                                          .doc(widget.postId)
                                          .collection("bids")
                                          .doc(widget.bid[i])
                                          .delete();
                                    }
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "posts": FieldValue.arrayRemove(
                                          [widget.postId]),
                                    });
                                    String id = Uuid().v1();
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.uid)
                                        .collection('Notifications')
                                        .doc(id)
                                        .set({
                                      'product image': widget.imageUrl,
                                      'buyer name': userData1['username'],
                                      'body': 'I accepted you bid offer',
                                      'uid': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'profile': userData1['profileUrl'],
                                      'time': DateTime.now(),
                                    });
                                    await FirebaseFirestore.instance
                                        .collection("Products")
                                        .doc(widget.postId)
                                        .delete();
                                    LocalNotificationService.sendPushMessage(
                                        "${userData1['username']} accepted your bid",
                                        "Bid Accept",
                                        userData['token']);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                              content: Container(
                                                  height: 180,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 28,
                                                          backgroundColor:
                                                              Colors.green,
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Your Message send to the Buyer wait until he replied to you',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 120,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Dismiss',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ])));
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor: Colors.green,
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('Products')
                                        .doc(widget.postId)
                                        .collection('bids')
                                        .doc(snap['uid'])
                                        .delete();
                                    await FirebaseFirestore.instance
                                        .collection('Products')
                                        .doc(widget.postId)
                                        .update({
                                      'bids':
                                          FieldValue.arrayRemove([snap['uid']])
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor: Colors.red,
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ],
      ),
    );
  }
}

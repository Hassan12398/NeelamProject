// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/frontend/bid/bid_screen.dart';
import 'package:nelaamproject/frontend/message/message.dart';
import 'package:nelaamproject/widgets/snackbar.dart';

import 'cart.dart';

class ItemDetailsPage extends StatefulWidget {
  String imageUrl;
  String uid;
  String price;
  String bid;
  String details;
  String name;
  String postId;
  int bidlength;
  int rating;
  int reviews;
  bool status;
  List bidL;
  ItemDetailsPage({
    super.key,
    required this.bid,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.details,
    required this.bidlength,
    required this.status,
    required this.postId,
    required this.bidL,
    required this.rating,
    required this.reviews,
    required this.uid,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
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
      BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(uid)
          .set({
        'uid': uid,
        'lastMessage': '',
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
        'lastMessage': '',
        'profileImage': prof1,
        'time': DateTime.now(),
      });
      Get.to(
          message_screen(
            // chatId: uid,
            uid: uid,
          ),
          transition: Transition.rightToLeft);
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    int show = int.parse(widget.price);
    String title =
        'The best price of Dell Inspiron 15 3000 in Pakistan is Rs.131,299 and the lowest price found is Rs.58,999. The prices of Dell Inspiron 15 3000 is collected from the most trusted online stores in Pakistan such as daraz.pk, mega.pk, shophive.com, and tajori.pk . The collected prices were updated on Sept. 26, 2022, 11:25 a.m.';
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
          Container(
            height: 220,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken),
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover)),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.6),
                          radius: 17,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 200,
            right: 0,
            left: 0,
            bottom: 60,
            child: Container(
              height: MediaQuery.of(context).size.height - 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Product Price',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${widget.price} Rs',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Minimum Bid',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.bid} Rs',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      child: Text(
                        widget.details.length < 250
                            ? widget.details
                            : widget.details.replaceRange(
                                247, widget.details.length, '...'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'Bids  (${widget.bidlength})',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing: Icon(Icons.arrow_forward_ios,size: 19,),
                    ),
                    widget.bidlength == 0
                        ? Container(
                            color: Color.fromARGB(255, 233, 232, 232),
                            height: 80,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'There is No bid on this Product',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .doc(widget.postId)
                                .collection('bids')
                                .orderBy('bid price', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  color: Color.fromARGB(255, 233, 232, 232),
                                  height: 80,
                                  width: double.infinity,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length > 3
                                      ? 3
                                      : snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var snap =
                                        snapshot.data!.docs[index].data();
                                    return Container(
                                      color: Color.fromARGB(255, 233, 232, 232),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              NetworkImage(snap['imageUrl']),
                                          radius: 17,
                                        ),
                                        // tileColor: Colors.red,
                                        title: Text(
                                          snap['username'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        trailing: Text(
                                          '${snap['bid price']} Rs',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                    widget.uid == FirebaseAuth.instance.currentUser!.uid
                        ? widget.bidlength <= 3
                            ? Container()
                            : Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Text('View more >>')),
                                  ],
                                ),
                              )
                        : Container(),
                    ListTile(
                      leading: Text(
                        'Seller Profile',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing: Icon(Icons.arrow_forward_ios,size: 19,),
                    ),
                    Container(
                      color: Color.fromARGB(255, 233, 232, 232),
                      child: ListTile(
                          leading: isLoading
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      'https://irisvision.com/wp-content/uploads/2019/01/no-profile-1-1200x1200.png'),
                                  radius: 23,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(userData['profileUrl']),
                                  radius: 23,
                                ),
                          // tileColor: Colors.red,
                          title: Text(
                            isLoading
                                ? 'Loading...'
                                : userData['username'].toString().length < 10
                                    ? userData['username'].toString()
                                    : userData['username']
                                        .toString()
                                        .replaceRange(
                                            10,
                                            userData['username']
                                                .toString()
                                                .length,
                                            '...'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 19,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 217, 216, 216),
                    offset: Offset(3, -6),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.uid ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        Showsnackbar(context,
                            'You are a user you cann\'t chat with yourself!');
                      } else {
                        CreateChatRoom(
                            userData['uid'],
                            userData1['username'],
                            userData['username'],
                            userData1['profileUrl'],
                            userData['profileUrl'],
                            context);
                      }
                    },
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                        color: Colors.grey,
                      ))),
                      child: Icon(
                        CupertinoIcons.chat_bubble_text,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.uid ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        Showsnackbar(context,
                            'You\'re a seller you cannot bid on this product');
                      } else {
                        if (widget.bidL
                            .contains(FirebaseAuth.instance.currentUser!.uid)) {
                          Showsnackbar(
                              context, 'You already bid on this product');
                        } else {
                          Get.to(
                              bid_screen(
                                postId: widget.postId,
                                minBid: int.parse(widget.bid),
                                price: int.parse(widget.price),
                              ),
                              transition: Transition.rightToLeft);
                        }
                      }
                    },
                    child: Container(
                      height: 40.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 26, 69, 145),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Bid It",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 250, 250, 250),
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 26, 69, 145),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 250, 250, 250),
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Products')
                          .doc(widget.postId)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.grey,
                            ))),
                            child: Icon(
                              Icons.bookmark,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () async {
                            List uid = [FirebaseAuth.instance.currentUser!.uid];
                            List postId = [widget.postId];
                            if (!snapshot.data?['likes'].contains(
                                FirebaseAuth.instance.currentUser!.uid)) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.postId)
                                  .update({
                                "likes": FieldValue.arrayUnion(uid),
                              });
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "like posts": FieldValue.arrayUnion(postId),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Colors.blue,
                                    onPressed: () {
                                      // Code to execute.
                                      FirebaseFirestore.instance
                                          .collection('Products')
                                          .doc(widget.postId)
                                          .update({
                                        "likes": FieldValue.arrayRemove(uid),
                                      });
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "like posts":
                                            FieldValue.arrayRemove(postId),
                                      });
                                    },
                                  ),
                                  content: Text(
                                      'Add item to wishlist Successfully!'),
                                  //backgroundColor: Colors.blueGrey,
                                  duration: const Duration(milliseconds: 1000),
                                  width: 350.0, // Width of the SnackBar.
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        10.0, // Inner padding for SnackBar content.
                                  ),

                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            } else {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.postId)
                                  .update({
                                "likes": FieldValue.arrayRemove(uid),
                              });
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "like posts": FieldValue.arrayRemove(postId),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    textColor: Colors.blue,
                                    label: 'Undo',
                                    onPressed: () {
                                      // Code to execute.
                                      FirebaseFirestore.instance
                                          .collection('Products')
                                          .doc(widget.postId)
                                          .update({
                                        "likes": FieldValue.arrayUnion(uid),
                                      });
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "like posts":
                                            FieldValue.arrayUnion(postId),
                                      });
                                    },
                                  ),
                                  content: Text(
                                      'Deleted item from wishlist Successfully!'),
                                  //backgroundColor: Colors.blueGrey,
                                  duration: const Duration(milliseconds: 1000),
                                  width: 350.0, // Width of the SnackBar.
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        10.0, // Inner padding for SnackBar content.
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.grey,
                            ))),
                            child: Icon(
                              snapshot.data?['likes'].contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              color: snapshot.data?['likes'].contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? Color.fromARGB(255, 253, 232, 37)
                                  : Colors.black,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

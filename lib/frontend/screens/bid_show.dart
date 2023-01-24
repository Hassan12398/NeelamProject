import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/Widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

class bid_Show extends StatefulWidget {
  String postId;
  String product;
  String uid;
  bid_Show(
      {super.key,
      required this.postId,
      required this.uid,
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
            'Hi you send me bid on my $product and i accepted your bid request if you want to buy my product you can contact me',
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
          .doc(uid)
          .collection('messages')
          .doc(postId)
          .set({
        'message':
            'Hi you send me bid on my $product and i accepted your bid request if you want to buy my product you can contact me',
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
                                  onTap: () {
                                    CreateChatRoom(
                                        userData['uid'],
                                        userData1['username'],
                                        userData['username'],
                                        userData1['profileUrl'],
                                        userData['profileUrl'],
                                        widget.product,
                                        context);
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

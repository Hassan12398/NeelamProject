import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:nelaamproject/widgets/floating_bubble.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/snackbar.dart';

class message_screen extends StatefulWidget {
  String uid;
  message_screen({super.key, required this.uid});

  @override
  State<message_screen> createState() => _message_screenState();
}

class _message_screenState extends State<message_screen> {
  TextEditingController _message = TextEditingController();
  ScrollController _controller = ScrollController();
  bool istyping = false;
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
        userData = Usersnap.data()!;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  SendMessage(
    String ChatId,
    String Message,
    String uid,
    String name,
  ) async {
    try {
      if (Message.isNotEmpty) {
        String postId = Uuid().v1();
        var time = DateTime.now();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Chatrooms')
            .doc(ChatId)
            .collection('messages')
            .doc(postId)
            .set({
          'message': Message,
          'chatId': ChatId,
          'uid': uid,
          'name': name,
          'read': false,
          'type': 'text',
          'time': DateTime.now(),
          'postId': postId,
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ChatId)
            .collection('Chatrooms')
            .doc(uid)
            .collection('messages')
            .doc(postId)
            .set({
          'message': Message,
          'chatId': ChatId,
          'uid': uid,
          'read': false,
          'name': name,
          'type': 'text',
          'time': DateTime.now(),
          'postId': postId,
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('Chatrooms')
            .doc(ChatId)
            .update({'lastMessage': 'text'});
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ChatId)
            .collection('Chatrooms')
            .doc(uid)
            .update({'lastMessage': 'text'});
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('Chatrooms')
            .doc(ChatId)
            .update({'time': DateTime.now()});
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ChatId)
            .collection('Chatrooms')
            .doc(uid)
            .update({'time': DateTime.now()});
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: istyping
          ? Padding(
              padding: const EdgeInsets.all(3.0),
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 45, 79, 106),
                onPressed: () async {
                  Feedback.forTap(context);
                  HapticFeedback.mediumImpact();
                  SendMessage(
                      widget.uid,
                      _message.text,
                      FirebaseAuth.instance.currentUser!.uid,
                      userData['username']);

                  setState(() {
                    _message.text = "";
                    _controller.animateTo(_controller.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                    istyping = false;
                  });
                },
                child: Icon(
                  Icons.send,
                  // size: 30,
                  color: Colors.white,
                ),
              ),
            )
          : floatingButton(),
      appBar: AppBar(
        title: Center(
            child: Text(
          'Inbox',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        actions: [
          Container(
            height: 10,
            width: 45,
            color: Colors.transparent,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 223, 222, 222),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(children: [
          Expanded(
              child:
                  // onTap: () {
                  //   // setState(() {
                  //   //   show = false;
                  //   //   focusNode.unfocus();
                  //   // });
                  // },
                  CupertinoScrollbar(
            controller: _controller,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Chatrooms')
                    .doc(widget.uid)
                    .collection('messages')
                    .orderBy(
                      'time',
                    )
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _controller.animateTo(_controller.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                  });
                  return ListView.builder(
                      controller: _controller,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == snapshot.data!.docs.length) {
                          return Container(
                            height: 40,
                          );
                        }
                        var snap = snapshot.data!.docs[index].data();
                        return snap['type'] == 'text'
                            ? snap['uid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? messageCard(
                                    // check: false,
                                    // check2: false,
                                    // read: snap['read'],
                                    message: snap['message'],
                                    time: snap['time'])
                                : messageCard1(
                                    message: snap['message'],
                                    time: snap['time'],
                                    // url: userData2['photoUrl'],
                                  )
                            : snap['type'] == 'image'
                                ? snap['uid'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? imageCard(
                                        // read: snap['read'],
                                        // title: snap['title'],
                                        // imagee: snap['imageUrl'],
                                        // time: snap['time']
                                        )
                                    : imageCard1(
                                        // imagee: snap['imageUrl'],
                                        // time: snap['time'],
                                        // url: userData2['photoUrl'],
                                        )
                                // : snap['type'] == 'video'
                                //     ? snap['uid'] ==
                                //             FirebaseAuth
                                //                 .instance.currentUser!.uid
                                //         ? video(
                                //             read: snap['read'],
                                //             title: snap['title'],
                                //             imagee: snap['thumbnail'],
                                //             videoUrl: snap['videoUrl'],
                                //             time: snap['time'])
                                //         : video1(
                                //             videoUrl: snap['videoUrl'],
                                //             title: snap['title'],
                                //             imagee: snap['thumbnail'],
                                //             time: snap['time'],
                                //             url: userData2['photoUrl'],
                                //           )
                                // : snap['type'] == 'file'
                                //     ? snap['uid'] ==
                                //             FirebaseAuth.instance
                                //                 .currentUser!.uid
                                //         ? fileCard(
                                //             name: snap['filename'],
                                //             read: snap['read'],
                                //             url: snap['FileUrl'],
                                //             size: snap['size'],
                                //             type: snap['ext'],
                                //             time: snap['time'])
                                //         : fileCard1(
                                //             url: snap['FileUrl'],
                                //             pic:
                                //                 userData2['photoUrl'],
                                //             name: snap['filename'],
                                //             read: snap['read'],
                                //             size: snap['size'],
                                //             type: snap['ext'],
                                //             time: snap['time'])
                                : snap['uid'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? audioCard(
                                        // dur: snap['duration'],
                                        // read: snap['read'],
                                        // url: snap['voiceUrl'],
                                        // time: snap['time'],
                                        // Imageurl:
                                        //     userData['photoUrl'],
                                        )
                                    : audioCard1(
                                        // dur: snap['duration'],
                                        // url: snap['voiceUrl'],
                                        // time: snap['time'],
                                        // Imageurl:
                                        //     userData2['photoUrl'],
                                        );
                        // if (index == snapshot.data!.docs.length) {
                        //   return Container(
                        //     height: 20,
                        //   );
                        // }
                      });
                }),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ]),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(22),
                        //     topRight: Radius.circular(22)),
                        // borderRadius: BorderRadius.circular(30)
                        ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: ((value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                istyping = true;
                              });
                            } else {
                              setState(() {
                                istyping = false;
                              });
                            }
                          }),
                          controller: _message,

                          maxLines: 2,
                          minLines: 1,
                          // autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          // keyboardType: TextInputType.,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Say Something...',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class imageCard1 extends StatelessWidget {
  const imageCard1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
        margin: BubbleEdges.only(top: 10, right: 60),
        alignment: Alignment.topLeft,
        nipWidth: 15,
        elevation: 15,
        nipHeight: 10,
        nip: BubbleNip.leftBottom,
        radius: Radius.circular(18),
        color: Color.fromARGB(255, 45, 79, 106),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("images/nelamI.png")));
  }
}

class imageCard extends StatelessWidget {
  const imageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
        margin: BubbleEdges.only(top: 10, left: 60),
        alignment: Alignment.topRight,
        nipWidth: 15,
        elevation: 15,
        nipHeight: 10,
        nip: BubbleNip.rightBottom,
        radius: Radius.circular(18),
        color: Color.fromARGB(255, 174, 209, 232),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("images/nelamI.png")));
  }
}

class messageCard1 extends StatelessWidget {
  String message;
  final time;
  messageCard1({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, right: 60, bottom: 5),
          alignment: Alignment.topLeft,
          nipWidth: 15,
          elevation: 3,
          nipHeight: 10,
          nip: BubbleNip.leftBottom,
          radius: Radius.circular(18),
          color: Color.fromARGB(255, 45, 79, 106),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 30, right: 20, bottom: 10),
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class messageCard extends StatelessWidget {
  String message;
  final time;
  messageCard({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, left: 60, bottom: 5),
          // borderWidth: 2000,
          alignment: Alignment.topRight,
          nipWidth: 15,
          elevation: 3,
          nipHeight: 10,
          nip: BubbleNip.rightBottom,
          radius: Radius.circular(14),
          color: Color.fromARGB(255, 174, 209, 232),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 30, right: 20, bottom: 10),
            child: Text(
              message,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class audioCard extends StatefulWidget {
  const audioCard({super.key});

  @override
  State<audioCard> createState() => _audioCardState();
}

class _audioCardState extends State<audioCard> {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 10, right: 60),
      alignment: Alignment.topLeft,
      nipWidth: 15,
      nipHeight: 10,
      nip: BubbleNip.leftBottom,
      radius: Radius.circular(18),
      color: Color.fromARGB(255, 30, 76, 106),
      // child: Text(
      //   'Helloe how are you i am fine and you r my best friend i like you you are best gggg pubg gg',
      //   textAlign: TextAlign.right,
      //   style: TextStyle(
      //     fontSize: 17,
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: Colors.transparent,
            ),
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Stack(children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 3, left: 15, right: 8, bottom: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage("images/nelamI.png"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          // if (isplaying) {
                          //   await audioplayer.pause();
                          // } else {
                          //   await audioplayer
                          //       .play(UrlSource(widget.url));
                          //   buff = true;
                          //   await Future.delayed(
                          //       Duration(seconds: 2));
                          //   buff = false;
                          // }

                          setState(() {});
                        },
                        child: Icon(
                          // isplaying ? Icons.pause :
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Slider(
                            thumbColor: Colors.white,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            min: 0,
                            max: 100,
                            value: 60,
                            onChanged: (v) async {
                              // final position =
                              //     Duration(seconds: v.toInt());
                              // await audioplayer.seek(position);
                              // await audioplayer.resume();
                            }),
                      ),
                      Text(
                        "10:10",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              // Positioned(
              //   bottom: 4,
              //   right: 10,
              //   child:
              // )
            ]),
          ),
        ],
      ),
    );
  }
}

class audioCard1 extends StatefulWidget {
  const audioCard1({super.key});

  @override
  State<audioCard1> createState() => _audioCard1State();
}

class _audioCard1State extends State<audioCard1> {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 10, left: 60),
      alignment: Alignment.topRight,
      nipWidth: 15,
      nipHeight: 10,
      nip: BubbleNip.rightBottom,
      radius: Radius.circular(18),
      color: Color.fromARGB(255, 30, 76, 106),
      // child: Text(
      //   'Helloe how are you i am fine and you r my best friend i like you you are best gggg pubg gg',
      //   textAlign: TextAlign.right,
      //   style: TextStyle(
      //     fontSize: 17,
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: Colors.transparent,
            ),
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: Stack(children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 3, left: 15, right: 8, bottom: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage("images/nelamI.png"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          // if (isplaying) {
                          //   await audioplayer.pause();
                          // } else {
                          //   await audioplayer
                          //       .play(UrlSource(widget.url));
                          //   buff = true;
                          //   await Future.delayed(
                          //       Duration(seconds: 2));
                          //   buff = false;
                          // }

                          setState(() {});
                        },
                        child: Icon(
                          // isplaying ? Icons.pause :
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Slider(
                            thumbColor: Colors.white,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            min: 0,
                            max: 100,
                            value: 60,
                            onChanged: (v) async {
                              // final position =
                              //     Duration(seconds: v.toInt());
                              // await audioplayer.seek(position);
                              // await audioplayer.resume();
                            }),
                      ),
                      Text(
                        "10:10",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              // Positioned(
              //   bottom: 4,
              //   right: 10,
              //   child:
              // )
            ]),
          ),
        ],
      ),
    );
  }
}

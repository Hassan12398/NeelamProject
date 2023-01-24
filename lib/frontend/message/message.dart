// import 'dart:html';
import 'dart:io';
import 'package:audioplayers_platform_interface/api/player_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:bubble/bubble.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nelaamproject/widgets/floating_bubble.dart';
import 'package:nelaamproject/widgets/message_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../widgets/snackbar.dart';

class message_screen extends StatefulWidget {
  String uid;
  message_screen({super.key, required this.uid});

  @override
  State<message_screen> createState() => _message_screenState();
}

class _message_screenState extends State<message_screen>
    with SingleTickerProviderStateMixin {
  TextEditingController _message = TextEditingController();
  late Animation<double> _animation;
  late AnimationController _animationController;
  ScrollController _controller = ScrollController();
  bool istyping = false;
  bool isLoading = false;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    getData1();
    load();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
    initRecorder();
  }

  Future load() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });
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

  SendImage(
    String ChatId,
    File image,
    // String title,
  ) async {
    try {
      sending = true;
      String postId = Uuid().v1();
      String ImageUrl = await sendImage(image);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .collection('messages')
          .doc(postId)
          .set({
        'imageUrl': ImageUrl,
        'chatId': ChatId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        // 'title': title,
        'read': false,
        'type': 'image',
        'time': DateTime.now(),
        'postId': postId,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(postId)
          .set({
        'imageUrl': ImageUrl,
        'chatId': ChatId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        // 'title': title,
        'read': false,
        'type': 'image',
        'time': DateTime.now(),
        'postId': postId,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .update({'lastMessage': 'text'});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'lastMessage': 'text'});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .update({'time': DateTime.now()});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'time': DateTime.now()});
      // Get.back();
      sending = false;
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  SendVoice(
    String ChatId,
    String voiceUrl,
    String uid,
    String name,
    String time,
  ) async {
    try {
      String postId = Uuid().v1();
      // Int date = DateTime.now() as Int;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .collection('messages')
          .doc(postId)
          .set({
        'voiceUrl': voiceUrl,
        'chatId': ChatId,
        'uid': uid,
        'read': false,
        'name': name,
        'duration': time,
        'type': 'voice',
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
        'voiceUrl': voiceUrl,
        'chatId': ChatId,
        'uid': uid,
        'read': false,
        'name': name,
        'duration': time,
        'type': 'voice',
        'time': DateTime.now(),
        'postId': postId,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .update({'lastMessage': 'voice'});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(uid)
          .update({'lastMessage': 'voice'});
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

      setState(() {
        sending = false;
      });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  UploadTask? task;
  bool sending = false;
  bool isloading = false;
  Future sendImage(File image) async {
    // folder name & iamge name
    String postId = const Uuid().v1();
    Reference ref =
        FirebaseStorage.instance.ref().child('sendImage').child('$postId.jpg');
    // image is uploading from putData()
    setState(() {
      task = ref.putFile(image);
    });
    TaskSnapshot taskSnapshot = await task!;
    final snapshot = task!.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      sending = false;
    });
    return downloadUrl;
  }

  Future login() async {
    setState(() {
      sending = true;
    });
    SendImage(widget.uid, File(file!.path!));
    setState(() {
      sending = false;
    });
  }

  SendVideoF(
    String ChatId,
    File videoUrl,
    String uid,
  ) async {
    try {
      String postId = Uuid().v1();
      String videopath = await SendVideo(videoUrl);
      String Thumbnail = await SuploadImageVideo(videoUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .collection('messages')
          .doc(postId)
          .set({
        'videoUrl': videopath,
        'thumbnail': Thumbnail,
        'chatId': ChatId,
        'uid': uid,
        'read': false,
        'type': 'video',
        'time': DateTime.now(),
        'postId': postId
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(uid)
          .collection('messages')
          .doc(postId)
          .set({
        'videoUrl': videopath,
        'thumbnail': Thumbnail,
        'chatId': ChatId,
        'uid': uid,
        'read': false,
        'type': 'video',
        'time': DateTime.now(),
        'postId': postId
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Chatrooms')
          .doc(ChatId)
          .update({'lastMessage': 'Video'});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ChatId)
          .collection('Chatrooms')
          .doc(uid)
          .update({'lastMessage': 'Video'});
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
      // Get.back();
      setState(() {
        sending = false;
      });
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  // UploadTask? task;
  // bool isloading = false;
  SgetThumbnails(File videopath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
        video: videopath.path,
        // thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG);
    if (thumbnail!.isNotEmpty) {
      return thumbnail;
    } else {
      return Showsnackbar(context, 'error');
    }
  }

  Future<String> SuploadImageVideo(File VideoPath) async {
    var postId = Uuid().v1();
    Reference ref =
        FirebaseStorage.instance.ref().child('SThumbnails').child(postId);
    UploadTask uploadTask = ref.putData(await SgetThumbnails(VideoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String> SendVideo(File VideoPath) async {
    var postId = Uuid().v1();
    Reference ref =
        FirebaseStorage.instance.ref().child('Svideos').child(postId);
    task = ref.putFile(await VideoPath);
    TaskSnapshot snap = await task!;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  bool sendingV = false;
  Future login1() async {
    setState(() {
      sendingV = true;
    });
    SendVideoF(
        widget.uid, File(file!.path!), FirebaseAuth.instance.currentUser!.uid);
    // await SendVideo(File(widget.imagepath.path));
  }

  bool select = false;
  bool mic = false;
  PlatformFile? file;

  // bool mic = false;
  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'permission no granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  }

  Future start() async {
    await recorder.startRecorder(
      toFile: 'Audio.aac',
    );
  }

  Future stop() async {
    final String? path = await recorder.stopRecorder();
    // final String filepath = path!;

    // print(filepath.toString());
    //  SendVoice(File(path.toString()));
  }

  // UploadTask? task;
  Future<String> SendVoice1(File AudioPath) async {
    String? downloadurl;
    try {
      var postId = Uuid().v1();

      Reference ref =
          FirebaseStorage.instance.ref().child('Svoice').child(postId);
      setState(() {
        task = ref.putFile(
            AudioPath,
            SettableMetadata(
              contentType: 'audio/aac',
            ));
      });
      TaskSnapshot snap = await task!;
      downloadurl = await snap.ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('error 2 ', e.toString());
    }
    return downloadurl!;
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
                  // Feedback.forTap(context);

                  SendMessage(
                      widget.uid,
                      _message.text,
                      FirebaseAuth.instance.currentUser!.uid,
                      userData['username']);

                  setState(() {
                    _message.text = "";
                    HapticFeedback.heavyImpact();
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
          : mic
              ? Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 45, 79, 106),
                    onPressed: () async {
                      // Feedback.forTap(context);
                      if (recorder.isRecording) {
                        mic = false;

                        final String? path = await recorder.stopRecorder();
                        final String filepath = path!;

                        print(filepath.toString());
                        AudioPlayer just = AudioPlayer();
                        await just.setFilePath(filepath);
                        final duration = just.duration!;
                        String twodigets(int n) => n.toString().padLeft(2, '0');

                        final twomin =
                            twodigets(duration.inMinutes.remainder(60));
                        final twomsec =
                            twodigets(duration.inSeconds.remainder(60));

                        setState(() {
                          print('$twomin:$twomsec');
                          print(
                              'durationS ${just.duration!.toString().replaceAll('0:', '').split('.')[0]}');
                        });
                        setState(() {
                          sending = true;
                        });
                        String voiceUrl =
                            await SendVoice1(File(path.toString()));
                        SendVoice(
                          widget.uid,
                          voiceUrl,
                          FirebaseAuth.instance.currentUser!.uid,
                          userData['username'],
                          '$twomin:$twomsec',
                        );
                        // Fluttertoast.showToast(
                        //     msg: 'Voice Sucessfully Sended!!',
                        //     backgroundColor: kPrimaryColor);
                      }
                      ;
                    },
                    child: Icon(
                      Icons.send,
                      // size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FloatingActionBubble(
                    // Menu items
                    items: <Bubble>[
                      // Floating action menu item
                      Bubble(
                        title: "Photo",
                        iconColor: Colors.white,
                        bubbleColor: Color.fromARGB(255, 30, 76, 106),
                        icon: CupertinoIcons.photo,
                        titleStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () async {
                          _animationController.reverse();
                          setState(() {
                            select = false;
                            sending = true;
                          });
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          setState(() {
                            file = result!.files.first;
                            sending = true;
                          });
                          await login();
                          // setState(() {
                          //   sending = false;
                          // });
                        },
                      ),
                      // Floating action menu item
                      Bubble(
                        title: "Video",
                        iconColor: Colors.white,
                        bubbleColor: Color.fromARGB(255, 30, 76, 106),
                        icon: CupertinoIcons.video_camera,
                        titleStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () async {
                          _animationController.reverse();
                          setState(() {
                            select = false;
                            sending = true;
                          });
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.video,
                          );
                          setState(() {
                            file = result!.files.first;
                            sending = true;
                          });
                          await login1();
                        },
                      ),
                      //Floating action menu item
                      Bubble(
                        title: "Mic",
                        iconColor: Colors.white,
                        bubbleColor: Color.fromARGB(255, 30, 76, 106),
                        icon: CupertinoIcons.mic,
                        titleStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () async {
                          // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){

                          // }));
                          await start();
                          setState(() {
                            select = false;
                            mic = true;
                          });
                          _animationController.reverse();
                        },
                      ),
                    ],

                    // animation controller
                    animation: _animation,

                    // On pressed change animation state
                    onPress: () {
                      _animationController.isCompleted
                          ? _animationController.reverse()
                          : _animationController.forward();
                      if (select == false) {
                        setState(() {
                          select = true;
                        });
                      } else {
                        setState(() {
                          select = false;
                        });
                      }
                    },

                    // Floating Action button Icon color
                    iconColor: Colors.white,

                    // Flaoting Action button Icon
                    iconData: select ? Icons.close : Icons.add,
                    backGroundColor: Color.fromARGB(255, 30, 76, 106),
                  ),
                ),
      appBar: AppBar(
        title: Center(
            child: Text(
          'Inbox',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        elevation: 0,
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
          Align(
              alignment: Alignment.topCenter,
              child: sending == false
                  ? Container(
                      // height: 20,
                      // color: Colors.red,
                      )
                  : _buildSendFileStatus(task!)),
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

                  return loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                      : ListView.builder(
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
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? imageCard(
                                            // read: snap['read'],
                                            // title: snap['title'],
                                            imagee: snap['imageUrl'],
                                            time: snap['time'],
                                          )
                                        : imageCard1(
                                            imagee: snap['imageUrl'],
                                            time: snap['time'],
                                            // url: userData2['photoUrl'],
                                          )
                                    : snap['type'] == 'video'
                                        ? snap['uid'] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? videoCard(
                                                thumbnail: snap['thumbnail'],
                                                videoUrl: snap['videoUrl'],
                                                time: snap['time'],
                                              )
                                            : videoCard1(
                                                thumbnail: snap['thumbnail'],
                                                videoUrl: snap['videoUrl'],
                                                time: snap['time'],
                                              )
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
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? audioCard(
                                                dur: snap['duration'],
                                                // read: snap['read'],
                                                url: snap['voiceUrl'],
                                                time: snap['time'],
                                                imageUrl:
                                                    userData1['profileUrl'],
                                              )
                                            : audioCard1(
                                                dur: snap['duration'],
                                                url: snap['voiceUrl'],
                                                time: snap['time'],
                                                imageUrl:
                                                    userData['profileUrl'],
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
                  width: MediaQuery.of(context).size.width,
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
                  child: mic
                      ? Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 14,
                            ),
                            Container(
                              height: 50,
                              width: 300,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      recorder.stopRecorder();
                                      setState(() {
                                        mic = false;
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 30, 76, 106),
                                    ),
                                  ),
                                  LottieBuilder.asset(
                                    "images/record1.json",
                                    // height: 300,
                                    width: 200,
                                  ),
                                  StreamBuilder<RecordingDisposition>(
                                      stream: recorder.onProgress,
                                      builder: (context, snapshot) {
                                        final duration = snapshot.hasData
                                            ? snapshot.data!.duration
                                            : Duration.zero;
                                        String twodigets(int n) =>
                                            n.toString().padLeft(2, '0');

                                        final twomin = twodigets(
                                            duration.inMinutes.remainder(60));
                                        final twomsec = twodigets(
                                            duration.inSeconds.remainder(60));

                                        // if (mic == false) {
                                        //   voicetimer =
                                        //       '$twomin:$twomin';
                                        // }

                                        if (twomin == '20') {
                                          mic = false;
                                          recorder.stopRecorder();
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         'Voice must be 20 mins only');

                                          mic = false;
                                        }
                                        return Text('$twomin:$twomsec');
                                      }),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
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
                                textCapitalization:
                                    TextCapitalization.sentences,
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

  Widget _buildSendFileStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width - 70,
                    child: LinearProgressIndicator(
                      // color: Colors.white,
                      value: progress,
                    ),
                  ),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            );
          } else {
            return Container(
                color: Colors.transparent,
                height: 10,
                child: LinearProgressIndicator());
          }
        },
      );
}

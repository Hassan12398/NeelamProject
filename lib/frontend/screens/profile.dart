// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, dead_code

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:nelaamproject/backend/imagedata.dart';
import 'package:uuid/uuid.dart';

class PProfilePage extends StatefulWidget {
  const PProfilePage({super.key});

  @override
  State<PProfilePage> createState() => _PProfilePageState();
}

class _PProfilePageState extends State<PProfilePage> {
  bool editmod = true;
  var usermail = FirebaseAuth.instance.currentUser!.email;
  TextEditingController name = TextEditingController();
  TextEditingController currentemail = TextEditingController();
  // getting userdata
  var uid = FirebaseAuth.instance.currentUser!.uid;
  String username = "";
  String nameerror = "";
  String emailerror = "";
  String profilelink = "";
  // Uint8List? _image;
  ///////////rating lists//////
  List star1 = [];
  List star2 = [];
  List star3 = [];
  List star4 = [];
  List star5 = [];
  ///////////////////////
  PlatformFile? file;
  void selectImage() async {}

  var userdata = {};
  @override
  void initState() {
    getUserData();
    load();
    super.initState();
  }

  bool isLoading = false;
  Future getUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersD =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      userdata = usersD.data()!;
      setState(() {
        star1 = userdata['1 star'];
        star2 = userdata['2 star'];
        star3 = userdata['3 star'];
        star4 = userdata['4 star'];
        star5 = userdata['5 star'];
        username = userdata["username"];
        profilelink = userdata["profileUrl"];
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  UploadTask? task;
  Future<String> uploadImage(File image) async {
    var uuid = Uuid();
    var id = uuid.v1();
    // folder name & iamge name
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child('profileImages')
        .child('${id}.jpg');
    // image is uploading from putData()
    task = ref.putFile(image);
    TaskSnapshot taskSnapshot = await task!;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  bool loading = true;
  Future load() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      loading = false;
    });
  }

  rating() {
    // if (star5.length == 0 ||
    //     0 == star2.length ||
    //     0 == star1.length ||
    //     0 == star4.length ||
    //     0 == star3.length) {
    //   return 0.0;
    // } else {

    if (star2.length > star1.length &&
        star2.length > star3.length &&
        star2.length > star4.length &&
        star2.length > star5.length) {
      return 2.0;
    } else if (star1.length > star2.length &&
        star1.length > star3.length &&
        star1.length > star4.length &&
        star1.length > star5.length) {
      return 1.0;
    } else if (star3.length > star2.length &&
        star3.length > star1.length &&
        star3.length > star4.length &&
        star3.length > star5.length) {
      return 3.0;
    } else if (star4.length > star3.length &&
        star4.length > star1.length &&
        star4.length > star2.length &&
        star4.length > star5.length) {
      return 4.0;
    } else if (star5.length > star3.length &&
        star5.length > star2.length &&
        star5.length > star4.length &&
        star5.length > star1.length) {
      return 5.0;
    } else {
      return 0.0;
    }
    if (star1.length != 0) {
      if (star1.length == star2.length &&
          star1.length == star3.length &&
          star1.length == star5.length &&
          star1.length == star4.length) {
        return 1.0;
      }
    } else if (star2.length != 0) {
      if (star2.length == star1.length &&
          star2.length == star3.length &&
          star2.length == star5.length &&
          star2.length == star4.length) {
        return 2.0;
      }
    } else if (star3.length != 0) {
      if (star3.length == star1.length &&
          star3.length == star2.length &&
          star3.length == star5.length &&
          star3.length == star4.length) {
        return 3.0;
      }
    } else if (star4.length != 0) {
      if (star4.length == star1.length &&
          star4.length == star2.length &&
          star4.length == star5.length &&
          star4.length == star3.length) {
        return 4.0;
      } else if (star5.length != 0) {
        if (star5.length == star1.length &&
            star5.length == star2.length &&
            star5.length == star4.length &&
            star5.length == star3.length) {
          return 5.0;
        }
      }
    } else {
      return 0.0;
    }
  }

  // ending
  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : CircularProgressIndicator())
            ],
          ))
        : Scaffold(
            backgroundColor: Colors.white,
            // appbar

            appBar: AppBar(
              leading: editmod
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          editmod = !editmod;
                        });
                      },
                      icon: Icon(Icons.close)),
              backgroundColor: Color.fromARGB(255, 30, 76, 106),
              centerTitle: true,
              automaticallyImplyLeading: false,
              // elevation: 0.0,
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      editmod = !editmod;
                    });
                  },
                  child: editmod
                      ? Icon(Icons.edit, color: Colors.white)
                      : InkWell(
                          onTap: () async {
                            if (name.text.isEmpty &&
                                currentemail.text.isEmpty) {
                              setState(() {
                                nameerror = "Please Enter Name";
                                emailerror = "Please Enter Email";
                              });
                            } else if (name.text.isNotEmpty &&
                                currentemail.text != usermail &&
                                file == null) {
                              setState(() {
                                nameerror = "";
                                emailerror = "Please Enter Correct E-mail";
                              });
                            } else if (name.text.isEmpty &&
                                currentemail.text == usermail) {
                              setState(() {
                                nameerror = "Please Enter Name";
                                emailerror = "";
                              });
                            } else if (name.text.isEmpty &&
                                currentemail.text == usermail) {
                              setState(() {
                                nameerror = "Please Enter Name";
                                emailerror = "";
                              });
                            } else if (name.text.isNotEmpty &&
                                currentemail.text == usermail) {
                              setState(() {
                                nameerror = "";
                                emailerror = "";
                                editmod = true;
                              });
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
                                                  LottieBuilder.asset(
                                                    'images/upload.json',
                                                    height: 100,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  _buildSendFileStatus(task!),
                                                ])));
                                  });
                              String imageUrl = file == null
                                  ? userdata['profileUrl']
                                  : await uploadImage(File(file!.path!));
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uid)
                                  .update({
                                "username": name.text,
                                "profileUrl": imageUrl,
                              });
                              Get.back();
                            }
                          },
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
            // end
            body: SingleChildScrollView(
              child: editmod
                  ? Column(
                      children: [
                        // SizedBox(height: 100.0),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 30, 76, 106),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(60.0),
                            //   topRight: Radius.circular(60.0),
                            // ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(profilelink),
                                radius: 60,
                              ),
                              // name
                              Text(
                                username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.0,
                                ),
                              ),
                              // username
                              Text(
                                "$usermail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              // rating
                              Container(
                                height: 30.0,
                                width: 210.0,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 30, 76, 106),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Rating:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // SizedBox(width:10),
                                    SizedBox(
                                      height: 30.0,
                                      // width: 150.0,
                                      child: RatingBarIndicator(
                                        rating: rating().toDouble(),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40.0),
                              // response
                              rating() == 4 || rating() == 5
                                  ? ProfileConst(
                                      res: "Positive",
                                      getcolor: Colors.green,
                                    )
                                  : Container(),
                              rating() == 3 || rating() == 2
                                  ? ProfileConst(
                                      res: "Neutral",
                                      getcolor: Colors.blue,
                                    )
                                  : Container(),
                              rating() == 2 || rating() == 1
                                  ? ProfileConst(
                                      res: "Negative",
                                      getcolor: Colors.red,
                                    )
                                  : Container(),
                              // end
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        // SizedBox(height: 100.0),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 30, 76, 106),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(60.0),
                            //   topRight: Radius.circular(60.0),
                            // ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  file == null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                              userdata['profileUrl']),
                                          radius: 60,
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              FileImage(File(file!.path!)),
                                          radius: 60,
                                        ),
                                  SizedBox(width: 8.0),
                                  IconButton(
                                    onPressed: () async {
                                      final result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                      );
                                      setState(() {
                                        file = result!.files.first;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              // name
                              Text(
                                username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                height: 250.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 30, 76, 106),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 8.0),
                                    Text(
                                      "Change Name:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            controller: name,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          nameerror,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // email
                                        SizedBox(height: 12.0),
                                        Text(
                                          "E-MAIl ADDRESS",
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
                                            controller: currentemail,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          emailerror,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                    width: 188,
                    child: LinearProgressIndicator(
                      color: Colors.blue,
                      value: progress,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(fontWeight: FontWeight.bold),
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

class ProfileConst extends StatelessWidget {
  String res = "";
  Color? getcolor;
  ProfileConst({
    required this.res,
    required this.getcolor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: getcolor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            "$res Response",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "one month",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "six month",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "twelve month",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

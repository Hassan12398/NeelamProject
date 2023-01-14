// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nelaamproject/backend/imagedata.dart';

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
  Uint8List? _image;

  ///////////////////////
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  var userdata = {};
  @override
  void initState() {
    getUserData();
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

  // ending
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
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
                      if (name.text.isEmpty && currentemail.text.isEmpty) {
                        setState(() {
                          nameerror = "Please Enter Name";
                          emailerror = "Please Enter Email";
                        });
                      } else if (name.text.isNotEmpty &&
                          currentemail.text != usermail &&
                          _image == null) {
                        setState(() {
                          nameerror = "";
                          emailerror = "Please Enter Correct E-mail";
                        });
                      } else if (name.text.isEmpty &&
                          currentemail.text == usermail &&
                          _image == null) {
                        setState(() {
                          nameerror = "";
                          emailerror = "";
                        });
                      } else if (name.text.isEmpty &&
                          currentemail.text == usermail &&
                          _image != null) {
                        setState(() {
                          nameerror = "";
                          emailerror = "";
                        });
                      } else if (name.text.isNotEmpty &&
                          currentemail.text == usermail &&
                          _image != null) {
                        setState(() {
                          nameerror = "";
                          emailerror = "";
                          editmod = true;
                        });
                        // String imageUrl =
                        //     await UserImageUpload().uploadImage(_image!);
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .update({
                          "username": name.text,
                          "profileUrl": "imageUrl",
                        });
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Rating:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                                width: 150.0,
                                child: Slider(
                                  value: 5.0,
                                  min: 2.0,
                                  max: 10.0,
                                  onChanged: (a) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        // response
                        ProfileConst(
                          res: "Positive",
                          getcolor: Colors.green,
                        ),
                        ProfileConst(
                          res: "Neutral",
                          getcolor: Colors.blue,
                        ),
                        ProfileConst(
                          res: "Negative",
                          getcolor: Colors.red,
                        ),
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
                            _image == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        'https://th.bing.com/th/id/R.005bb6d69349a65c9f29d3d936fa9c77?rik=MX%2brNFZsyUoY0Q&pid=ImgRaw&r=0'),
                                    radius: 60,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: MemoryImage(_image!),
                                    radius: 60,
                                  ),
                            SizedBox(width: 8.0),
                            IconButton(
                              onPressed: () {
                                selectImage();
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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

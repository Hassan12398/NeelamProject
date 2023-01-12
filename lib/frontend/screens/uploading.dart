// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nelaamproject/backend/auth/postingproduct.dart';
import 'package:nelaamproject/frontend/screens/selling.dart';

import '../../backend/imagedata.dart';

class UploadingPage extends StatefulWidget {
  const UploadingPage({super.key});

  @override
  State<UploadingPage> createState() => _UploadingPageState();
}

class _UploadingPageState extends State<UploadingPage> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bid = TextEditingController();
  String? valuechanges;
  List catagi = [
    "Books",
    "Clothing, Shoes & Accessories",
    "Collectibles",
    "Consumer Electronics",
    "Crafts",
    "Dolls & Bears",
    "Home & Garden",
    "Sporting Goods",
    "Toys & Hobbies",
    "Antiques"
  ];
  Uint8List? _image;
  bool ename = false;
  bool edetails = false;
  bool eprice = false;
  bool ebid = false;
  ///////////////////////
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 30, 76, 106),
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Upload",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // end
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image + button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _image == null
                        ? Container(
                            height: 150.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 12, 77, 131),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          )
                        : Container(
                            height: 150.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_image!),
                              ),
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 12, 77, 131),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child: Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * 0.37,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 12, 77, 131),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Center(
                          child: Text(
                            "Select Image",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // data
              SizedBox(height: 12.0),
              Text(
                "Product Name :",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  errorText: ename ? "Please Enter Product Name" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "Product Details:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: details,
                decoration: InputDecoration(
                  errorText: edetails ? "Please Enter Product Details" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "Price:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: price,
                decoration: InputDecoration(
                  errorText: eprice ? "Please Enter Product Price" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "Minimum Bid:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: bid,
                decoration: InputDecoration(
                  errorText: ebid ? "Please Enter Product Bid" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "Select Category:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                height: 60,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Card(
                  elevation: 0,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                isDense: true,
                                value: valuechanges,
                                hint: Text("Select"),
                                items:
                                    catagi.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  setState(() {
                                    valuechanges = v;
                                  });
                                }),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (details.text.isEmpty &&
                          price.text.isEmpty &&
                          name.text.isEmpty &&
                          bid.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                          ename = true;
                          ebid = true;
                        });
                      }
                      if (details.text.isNotEmpty &&
                          price.text.isEmpty &&
                          name.text.isEmpty &&
                          bid.text.isEmpty) {
                        setState(() {
                          edetails = false;
                          eprice = true;
                          ename = true;
                          ebid = true;
                        });
                      }
                      if (details.text.isEmpty &&
                          price.text.isNotEmpty &&
                          name.text.isEmpty &&
                          bid.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = false;
                          ename = true;
                          ebid = true;
                        });
                      }
                      if (details.text.isEmpty &&
                          price.text.isEmpty &&
                          name.text.isNotEmpty &&
                          bid.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                          ename = false;
                          ebid = true;
                        });
                      }
                      if (details.text.isEmpty &&
                          price.text.isEmpty &&
                          name.text.isEmpty &&
                          bid.text.isNotEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                          ename = true;
                          ebid = false;
                        });
                      } else if (details.text.isEmpty && bid.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          ebid = true;
                        });
                      } else if (details.text.isEmpty && name.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          ename = true;
                        });
                      } else if (details.text.isEmpty && price.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                        });
                      } else if (details.text.isEmpty &&
                          price.text.isEmpty &&
                          bid.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                          ebid = true;
                        });
                      } else if (details.text.isEmpty &&
                          price.text.isEmpty &&
                          name.text.isEmpty) {
                        setState(() {
                          edetails = true;
                          eprice = true;
                          ename = true;
                        });
                      } else if (bid.text.isNotEmpty &&
                          details.text.isNotEmpty &&
                          price.text.isNotEmpty &&
                          bid.text.isNotEmpty) {
                        setState(() {
                          ename = false;
                          edetails = false;
                          eprice = false;
                          ebid = false;
                        });
                        await prodcutUpload(
                          name.text,
                          details.text,
                          price.text,
                          bid.text,
                          valuechanges!,
                          _image!,
                        );
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 77, 131),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          "Upload Product",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // end
            ],
          ),
        ),
      ),
    );
  }
}

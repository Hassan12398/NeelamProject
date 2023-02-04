// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/frontend/screens/itmedetails.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 30, 76, 106),
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        elevation: 5.0,
        title: Text(
          "Saved",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.help, color: Colors.white),
          SizedBox(width: 20.0),
        ],
      ),
      // end
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // bar
            Container(
              height: 6.0,
              width: double.infinity,
              color: Colors.white,
            ),
            // title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Your Saved Items",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  // color: Colors.white,
                ),
              ),
            ),
            // item
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("likes", arrayContains: uid)
                  .snapshots(),
              builder: ((context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    ],
                  );
                } else if (snapshot.data!.docs.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Center(
                        child: Text(
                          'You haven\'t Saved any Product',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return SavedConst(
                            savedData: snapshot.data!.docs[index],
                          );
                        })),
                  );
                }
              }),
            ),

            // end
          ],
        ),
      ),
    );
  }
}

class SavedConst extends StatelessWidget {
  dynamic savedData;
  SavedConst({
    required this.savedData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ItemDetailsPage(
                        bidL: savedData['bids'],
                        name: savedData['Product Name'],
                        uid: savedData['uid'],
                        bidlength: savedData['bids'].length,
                        bid: savedData['Minimum Bid'],
                        imageUrl: savedData['Product pic'],
                        postId: savedData['postId'],
                        details: savedData['Product Details'],
                        rating: savedData['rating'],
                        reviews: savedData['reviews'].length,
                        price: savedData['Price'],
                        status: savedData['bid on'],
                      )));
        },
        child: Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 4),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // data
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      savedData['Product Name'].toString().length < 10
                          ? savedData['Product Name'].toString()
                          : savedData['Product Name'].toString().replaceRange(
                              10,
                              savedData['Product Name'].toString().length,
                              '...'),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      "Seller Name :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      savedData['username'].toString().length < 10
                          ? savedData['username'].toString()
                          : savedData['username'].toString().replaceRange(10,
                              savedData['username'].toString().length, '...'),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              // image
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width - 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      savedData["Product pic"],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

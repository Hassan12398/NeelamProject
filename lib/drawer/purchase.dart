// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Purchases",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your recent purchases",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('recent purchase')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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
                  }
                  if (snapshot.data!.docs.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Center(
                          child: Text(
                            'You haven\'t Purchase any Product',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height - 120,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return purchase(
                            puchaseData: snapshot.data!.docs[index],
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class purchase extends StatelessWidget {
  var puchaseData;
  purchase({
    Key? key,
    required this.puchaseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 12, 77, 131),
            width: 3.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // data
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Name :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    puchaseData['product name'].toString().length < 10
                        ? puchaseData['product name'].toString()
                        : puchaseData['product name'].toString().replaceRange(
                            10,
                            puchaseData['product name'].toString().length,
                            '...'),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    "Price :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    puchaseData['price'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    "Date :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd()
                        .format(puchaseData['time'].toDate()),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
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
                // borderRadius: BorderRadius.only(
                //     topRight: Radius.circular(12),
                //     bottomRight: Radius.circular(12)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    puchaseData["product image"],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

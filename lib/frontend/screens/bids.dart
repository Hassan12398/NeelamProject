// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/frontend/screens/bid_show.dart';
import 'package:nelaamproject/frontend/screens/itmedetails.dart';

class BidsPage extends StatefulWidget {
  const BidsPage({super.key});

  @override
  State<BidsPage> createState() => _BidsPageState();
}

class _BidsPageState extends State<BidsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Bids",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // end
      body: SingleChildScrollView(
        child: Column(
          children: [
            // details
            Container(
              height: MediaQuery.of(context).size.height - 180,
              color: Colors.transparent,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Center(child: CircularProgressIndicator())],
                      );
                    }
                    if (snapshot.data!.docs.length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('You haven\'t upload any product'))
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var snap = snapshot.data!.docs[index].data();
                          return BidConst(
                            productname: snap['Product Name'],
                            url: snap['Product pic'],
                            bid: snap['bids'].length,
                            postId: snap['postId'],
                            bidL: snap['bids'],
                            name: snap['Product Name'],
                            uid: snap['uid'],
                            bidP: snap['Minimum Bid'],
                            details: snap['Product Details'],
                            rating: snap['rating'],
                            reviews: snap['reviews'].length,
                            price: snap['Price'],
                            status: snap['bid on'],
                          );
                        });
                  }),
            ),

            // end
          ],
        ),
      ),
    );
  }
}

class BidConst extends StatefulWidget {
  String url;
  String postId;
  var bidL;
  var name;
  String productname;
  var bidP;
  var details;
  var reviews;
  var status;
  var price;
  var rating;
  var uid;
  int bid;
  BidConst({
    Key? key,
    required this.postId,
    required this.productname,
    required this.url,
    required this.bid,
    required this.bidL,
    required this.bidP,
    required this.details,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.status,
    required this.uid,
  }) : super(
          key: key,
        );

  @override
  State<BidConst> createState() => _BidConstState();
}

class _BidConstState extends State<BidConst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Product Details",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(ItemDetailsPage(
                  bid: widget.bidP,
                  name: widget.name,
                  imageUrl: widget.url,
                  price: widget.price,
                  details: widget.details,
                  bidlength: widget.bid,
                  status: widget.status,
                  postId: widget.postId,
                  bidL: widget.bidL,
                  rating: widget.rating,
                  reviews: widget.reviews,
                  uid: widget.uid));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 12, 77, 131),
                    ),
                  ),
                  child: Image.network(widget.url, fit: BoxFit.cover)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bids on this product",
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios, size: 20),
              ),
            ],
          ),
          widget.bid == 0
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
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Color.fromARGB(255, 233, 232, 232),
                        height: 80,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length > 3
                            ? 3
                            : snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var snap = snapshot.data!.docs[index].data();
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  bid_Show(
                                    imageUrl: widget.url,
                                    bid: widget.bidL,
                                    product: widget.productname,
                                    uid: snap['uid'],
                                    postId: widget.postId,
                                  ),
                                  transition: Transition.rightToLeft);
                            },
                            child: BidderConst(
                              name: snap['username'],
                              price: snap['bid price'],
                            ),
                          );
                        });
                  }),

          // end
        ],
      ),
    );
  }
}

class BidderConst extends StatelessWidget {
  String name;
  int price;

  BidderConst({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // name
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                name.toString().length < 8
                    ? name.toString()
                    : name
                        .toString()
                        .replaceRange(6, name.toString().length, '...'),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "price:",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                price.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                // bid
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Bid",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 14.0),
                CircleAvatar(
                  radius: 12.0,
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 12.0,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // end
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/frontend/bid/bid_screen.dart';

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
  ItemDetailsPage({
    super.key,
    required this.bid,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.details,
    required this.bidlength,
    required this.postId,
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
    super.initState();
  }
  var userData = {};
  getData() async {
   setState(() {
      isLoading = true
      ;
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
            color: Colors.red,
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
                    Container(
                      height: 35,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          RatingBarIndicator(
                            rating: widget.rating.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${widget.rating}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      child: Text(
                        widget.details.length < 250
                            ? widget.details
                            : widget.details
                                .replaceRange(247, widget.details.length, '...'),
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
                   widget.bidlength==0?Container(
                     color: Color.fromARGB(255, 233, 232, 232),
                     height: 80,
                     width: double.infinity,
                     child: Center(
                       child: Text('There is No bid on this Product',style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                       ),),
                     ),
                   ): ListView.builder(
                      itemCount: 0,
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        return Container(
                          color: Color.fromARGB(255, 233, 232, 232),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 17,
                            ),
                            // tileColor: Colors.red,
                            title: Text(
                              'Hassan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              '7000 Rs',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  widget.bidlength<3?Container():  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){}, child: Text('View more >>')),
                        ],
                      ),
                    ),
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
                            leading:isLoading?CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage('https://irisvision.com/wp-content/uploads/2019/01/no-profile-1-1200x1200.png'),
                              radius: 23,
                            ): CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(userData['profileUrl']),
                              radius: 23,
                            ),
                            // tileColor: Colors.red,
                            title: Text(
                             isLoading? 'Loading...':userData['username']
                                                              .toString()
                                                              .length <
                                                          10
                                                      ? userData['username']
                                                          .toString()
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
                            trailing: Icon(Icons.arrow_forward_ios,size: 19,)
                          ),
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
                  Container(
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
                  InkWell(
                    onTap: () {
                      Get.to(bid_screen(),transition: Transition.rightToLeft);
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
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                      color: Colors.grey,
                    ))),
                    child: Icon(
                      Icons.favorite_border,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

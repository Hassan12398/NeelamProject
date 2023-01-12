// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cart.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(
                              'https://consumer.huawei.com/content/dam/huawei-cbg-site/me-africa/pk/mkt/plp/pc/matebook-x-pro-2021.jpg'),
                          fit: BoxFit.cover)),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
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
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Color.fromARGB(246, 255, 255, 255)),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        'Dell Laptop',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '⭐⭐⭐⭐⭐ 5.0',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 17),
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
                                'Price',
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
                        '10,000 Rs',
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
                        '5,000 Rs',
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
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 14),
                    child: Text(
                      title.length<250?title:title.replaceRange(247, title.length, '...'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
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
                    offset: Offset(3,-6),
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
                  )
                )
              ),
              child: Icon(CupertinoIcons.chat_bubble_text,),
            ),
                   InkWell(
              onTap: () {
                
              },
              child: Container(
                height: 40.0, 
                width: 70.0,
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 26, 69, 145),
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
            Text('Or',style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
             InkWell(
              onTap: () {
                
              },
              child: Container(
                height: 40.0, 
                width: 100.0,
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 26, 69, 145),
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
                  )
                )
              ),
              child: Icon(Icons.favorite_border,),
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

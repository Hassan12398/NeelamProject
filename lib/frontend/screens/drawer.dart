// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelaamproject/backend/auth/authFunctions.dart';
import 'package:nelaamproject/frontend/screens/welcome.dart';

import '../../drawer/bidsoffers.dart';
import '../../drawer/categories.dart';
import '../../drawer/faqs.dart';
import '../../drawer/notifications.dart';
import '../../drawer/purchase.dart';
import '../../drawer/saved.dart';
import '../../drawer/sellingitem.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 30, 76, 106),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // profile
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 76, 106),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black,
                  //     blurRadius: 4.0,
                  //     spreadRadius: 4.0,
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white54,
                            radius: 30.0,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 26.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "hassanbutt",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Hassan Butt",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              // items
              ItemsConst(geticon: Icons.home, label: "Home"),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotificationPage(),
                    ),
                  );
                },
                child: ItemsConst(
                    geticon: Icons.notifications, label: "Notification"),
              ),
              ItemsConst(geticon: Icons.message, label: "Messages"),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SavedPage(),
                    ),
                  );
                },
                child: ItemsConst(geticon: Icons.bookmark, label: "Saved"),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PurchasePage(),
                      ),
                    );
                  },
                  child: ItemsConst(geticon: Icons.store, label: "Purchases")),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BidsOffersPage(),
                    ),
                  );
                },
                child: ItemsConst(
                    geticon: Icons.gavel_sharp, label: "Bids and Offers"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SellingItemPage(),
                    ),
                  );
                },
                child: ItemsConst(geticon: Icons.sell, label: "Selling"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoriesPage(),
                    ),
                  );
                },
                child: ItemsConst(geticon: Icons.category, label: "Categories"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FAQSPage(),
                    ),
                  );
                },
                child: ItemsConst(geticon: Icons.help, label: "Help"),
              ),
              ItemsConst(geticon: Icons.star, label: "Rate Us"),
              InkWell(
                onTap: ()async{
                  AuthFunction().logout().then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return WelcomePage();
                    }));
                  });
                },
                child: ItemsConst(geticon: Icons.logout, label: "Logout")),
              // end
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsConst extends StatelessWidget {
  IconData? geticon;
  String label = "";
  ItemsConst({
    required this.geticon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 14.0, bottom: 14.0),
      child: Row(
        children: [
          Icon(geticon, color: Colors.white, size: 24.0),
          SizedBox(width: 40.0),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

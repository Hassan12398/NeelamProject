// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../frontend/screens/selling.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 243, 255),
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Categories",
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
            SizedBox(height: 12.0),
            // top deals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Top Deals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            // top deals row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TopDealsConst(title: "Books", image: "books"),
                  TopDealsConst(title: "Clothing, Shoes...", image: "clothing"),
                  TopDealsConst(title: "Collectibles", image: "collectibles"),
                ],
              ),
            ),
            // all
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "All Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopDealsConst(
                      title: "Consumer Electronics", image: "electronics"),
                  TopDealsConst(title: "Crafts", image: "crafts"),
                  TopDealsConst(title: "Dolls & Bears", image: "bears"),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TopDealsConst(title: "Home & Garden", image: "garden"),
                  TopDealsConst(title: "Sporting Goods", image: "sports"),
                  TopDealsConst(title: "Toys & Hobbies", image: "toys"),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopDealsConst(title: "Antiques", image: "antiques"),
                  TopDealsConst(title: "Books", image: "books"),
                  TopDealsConst(title: "Clothing, Shoes...", image: "clothing"),
                  TopDealsConst(title: "Collectibles", image: "collectibles"),
                ],
              ),
            ),
            // end
          ],
        ),
      ),
    );
  }
}

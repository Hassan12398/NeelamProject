// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/frontend/screens/categoryDetails.dart';

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
            Wrap(
              children: [
                TopDealsConst1(title: "Books", image: "books"),
                TopDealsConst1(
                    title: "Clothing, Shoes & Accessories", image: "clothing"),
                TopDealsConst1(title: "Collectibles", image: "collectibles"),
              ],
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
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                TopDealsConst1(title: "Crafts", image: "crafts"),
                TopDealsConst1(title: "Dolls & Bears", image: "bears"),
                TopDealsConst1(title: "Home & Garden", image: "garden"),
                TopDealsConst1(title: "Sporting Goods", image: "sports"),
                TopDealsConst1(title: "Toys & Hobbies", image: "toys"),
                TopDealsConst1(title: "Antiques", image: "antiques"),
                TopDealsConst1(title: "Books", image: "books"),
                TopDealsConst1(
                    title: "Clothing, Shoes & Accessories", image: "clothing"),
                TopDealsConst1(title: "Collectibles", image: "collectibles"),
                TopDealsConst1(
                    title: "Consumer Electronics", image: "electronics"),
              ],
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       TopDealsConst(title: "Home & Garden", image: "garden"),
            //       TopDealsConst(title: "Sporting Goods", image: "sports"),
            //       TopDealsConst(title: "Toys & Hobbies", image: "toys"),
            //     ],
            //   ),
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       TopDealsConst(title: "Antiques", image: "antiques"),
            //       TopDealsConst(title: "Books", image: "books"),
            //       TopDealsConst(title: "Clothing, Shoes...", image: "clothing"),
            //       TopDealsConst(title: "Collectibles", image: "collectibles"),
            //     ],
            //   ),
            // ),
            // end
          ],
        ),
      ),
    );
  }
}

class TopDealsConst1 extends StatelessWidget {
  String title = "";
  String image = "";
  TopDealsConst1({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          children: [
            OpenContainer(
                closedColor: Colors.transparent,
                middleColor: Color.fromARGB(255, 0, 0, 0),
                openColor: Color.fromARGB(255, 0, 0, 0),
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                closedElevation: 5.0,
                transitionDuration: Duration(
                  milliseconds: 500,
                ),
                transitionType: ContainerTransitionType.fade,
                openBuilder: (_, __) {
                  return CategoryDetails(categoryName: title);
                },
                closedBuilder: (_, __) {
                  return InkWell(
                      onTap: __,
                      child: Container(
                        height: 115,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 248, 190),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 84, 83, 83),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(-1, 5),
                              )
                            ]),
                        child: Center(
                          child: Image.asset("images/$image.png", height: 65.0),
                        ),
                      ));
                }),
            SizedBox(height: 8.0),
            Text(
              title.length < 17
                  ? title
                  : title.replaceRange(15, title.length, '...'),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ));
  }
}

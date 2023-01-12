// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class SellingItemPage extends StatefulWidget {
  const SellingItemPage({super.key});

  @override
  State<SellingItemPage> createState() => _SellingItemPageState();
}

class _SellingItemPageState extends State<SellingItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        shadowColor: Colors.white,
        elevation: 5.0,
        title: Text(
          "Selling",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // end
      body: Column(
        children: [
          // bar
          Container(
            height: 8.0,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(height: 40.0),
          // item list
          ItemsForSellConst(),
          ItemsForSellConst(),
          ItemsForSellConst(),
        ],
      ),
    );
  }
}

class ItemsForSellConst extends StatelessWidget {
  const ItemsForSellConst({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // data
            Column(
              children: [
                Text(
                  "Product Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            // image
            Image.asset("images/realwatch.png"),
          ],
        ),
      ),
    );
  }
}

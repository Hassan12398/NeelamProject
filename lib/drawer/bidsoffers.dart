// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class BidsOffersPage extends StatefulWidget {
  const BidsOffersPage({super.key});

  @override
  State<BidsOffersPage> createState() => _BidsOffersPageState();
}

class _BidsOffersPageState extends State<BidsOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Selling",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // end
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Text(
              "Active Bids and Offers",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          // items const
          BidsConst(),
          BidsConst(),
          BidsConst(),
          // end
        ],
      ),
    );
  }
}

class BidsConst extends StatelessWidget {
  const BidsConst({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 12, 77, 131),
            spreadRadius: 4.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // details
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product:",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Bids:",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          // image
          Image.asset("images/realwatch.png"),
        ],
      ),
    );
  }
}

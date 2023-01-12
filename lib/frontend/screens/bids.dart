// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container

import 'package:flutter/material.dart';

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
            BidConst(),
            BidConst(),
            // end
          ],
        ),
      ),
    );
  }
}

class BidConst extends StatelessWidget {
  const BidConst({
    Key? key,
  }) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 12, 77, 131),
                ),
              ),
              child: Center(
                child: Image.asset("images/realwatch.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Bids on this product",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
          BidderConst(),
          BidderConst(),
          BidderConst(),
          // end
        ],
      ),
    );
  }
}

class BidderConst extends StatelessWidget {
  const BidderConst({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Name:",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
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
                      fontSize: 20.0,
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

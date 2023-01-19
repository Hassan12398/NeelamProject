// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../drawer/sellingitem.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var data;
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
          "My Cart",
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
          ItemsForSellConst(
            productData: data,
          ),
          ItemsForSellConst(
            productData: data,
          ),
          // end
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutPage(),
            ),
          );
        },
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Center(
            child: Text(
              "Checkout",
              style: TextStyle(
                color: Color.fromARGB(255, 33, 141, 230),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

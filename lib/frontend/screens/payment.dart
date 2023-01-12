// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class PaymentSelectPage extends StatefulWidget {
  const PaymentSelectPage({super.key});

  @override
  State<PaymentSelectPage> createState() => _PaymentSelectPageState();
}

class _PaymentSelectPageState extends State<PaymentSelectPage> {
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
          "Payment",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Choose a way of payment.",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // ways
          PaymentConst(name: "jazzcash"),
          PaymentConst(name: "easypaisa"),
          PaymentConst(name: "visa"),
          // end
        ],
      ),
    );
  }
}

class PaymentConst extends StatelessWidget {
  String name = "";
  PaymentConst({
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:Color.fromARGB(255, 30, 76, 106),
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("images/$name.png"),
            Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 12, 77, 131),
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

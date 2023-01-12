// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.help, color: Colors.white),
          SizedBox(width: 10.0),
        ],
      ),
      // end
      body: Column(
        children: [
          TileConst(
            label: "Successful",
            pickcolor: Colors.green,
          ),
          TileConst(
            label: "Alert",
            pickcolor: Color.fromARGB(255, 255, 187, 0),
          ),
          TileConst(
            label: "Informative",
            pickcolor: Colors.blue,
          ),
          TileConst(
            label: "Cancelling",
            pickcolor: Colors.red,
          ),
          TileConst(
            label: "Vouchers",
            pickcolor: Color.fromARGB(255, 216, 155, 22),
          ),
        ],
      ),
    );
  }
}

class TileConst extends StatelessWidget {
  String label = "";
  Color? pickcolor;
  TileConst({
    required this.label,
    required this.pickcolor,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: pickcolor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

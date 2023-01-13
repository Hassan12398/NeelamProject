import 'package:flutter/material.dart';

class bid_screen extends StatefulWidget {
  const bid_screen({super.key});

  @override
  State<bid_screen> createState() => _bid_screenState();
}

class _bid_screenState extends State<bid_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Bid It',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 27),
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 12, 77, 131),
                  width: 3.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 84, 83, 83),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(2, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'How much you want to Bid for this Product',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 12, 77, 131),
                        width: 3.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

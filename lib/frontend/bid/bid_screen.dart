import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class bid_screen extends StatefulWidget {
  int price;
  int minBid;
  bid_screen({super.key,required this.price,required this.minBid});

  @override
  State<bid_screen> createState() => _bid_screenState();
}

class _bid_screenState extends State<bid_screen> {
  TextEditingController bid = TextEditingController(
    text: '20000'
  );
   int price = 0;
  @override
  void initState() {
    // TODO: implement initState
  price= widget.price;
    super.initState();

  }
  bool error = false;
  @override
  Widget build(BuildContext context) {
  //  int price = widget.price;
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
              height: 260.0,
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
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 12, 77, 131),
                        width: 3.0,
                      ),
                    ),
                    child: Row(children: [
                      Container(
                        height: 70,
                        width: 150,
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                                                  child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:4),
                                child: Text('${price}',style: TextStyle(
                                  fontSize:40,
                                ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [

                          GestureDetector(
                            onTap: (){
                              if (price<widget.price&&price>=widget.minBid) {
                                setState(() {
                                    price = price +500;
                              });
                              }
                                
                              
                            },
                            child: Container(
                                          height: 32,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: GestureDetector(
                              //   onTap: (){
                              //       setState(() {
                              //       price = price +500;
                              // });
                                // },
                                child: Center(child: Icon(Icons.arrow_drop_up,size:40))),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                               if (price>widget.minBid) {
                                setState(() {
                                    price = price -500;
                                    error = false;
                              });
                              }else{
                                setState(() {
                                  error = true;
                                });
                              }
                            },
                                                      child: Container(
                              height: 32,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    color: Color.fromARGB(255, 12, 77, 131),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                                child: Center(child: Icon(Icons.arrow_drop_down,size:40)),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  error? Text('*Bid should not be less then ${widget.minBid}',
                  style: TextStyle(
                    color:Colors.red,
                    fontSize:14,
                  ),
                  textAlign: TextAlign.center,):Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: () {},
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Color.fromARGB(255, 30, 76, 106),
                          child: Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      CupertinoButton(
                        onPressed: () {},
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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

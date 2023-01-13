// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'itmedetails.dart';

class SellingPage extends StatefulWidget {
  const SellingPage({super.key});

  @override
  State<SellingPage> createState() => _SellingPageState();
}

class _SellingPageState extends State<SellingPage> {

  bool loading = true;
  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
  }
  Future load()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      loading=false;
    });
  }
  String title = 'Dell Laptop';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      backgroundColor: Color.fromARGB(255, 228, 243, 255),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: DrawerPage(),
      ),
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          );
        }),
        title: Text(
          "Hub نیلام",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'What are you looking for ?',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
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
                  TopDealsConst(
                    title: "Music",
                    image: "music",
                  ),
                  TopDealsConst(
                    title: "Watch",
                    image: "watch",
                  ),
                  TopDealsConst(
                    title: "Video Games",
                    image: "gamepad",
                  ),
                ],
              ),
            ),
            // trends
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Trends",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
           loading?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Center(child: CircularProgressIndicator(
                          color:  Color.fromARGB(255, 30, 76, 106),
                        )),
                      ],
                    ): StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Center(child: CircularProgressIndicator(
                          color:  Color.fromARGB(255, 30, 76, 106),
                        )),
                      ],
                    );
                  }
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.start,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.85),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snap = snapshot.data!.docs[index].data();
                        int bid = snap['bids'].length;
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: OpenContainer(
                                closedColor: Colors.transparent,
                                middleColor: Color.fromARGB(255, 0, 0, 0),
                                openColor: Color.fromARGB(255, 0, 0, 0),
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                openShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                closedElevation: 5.0,
                                transitionDuration: Duration(
                                  milliseconds: 500,
                                ),
                                transitionType: ContainerTransitionType.fade,
                                openBuilder: (_, __) {
                                  return ItemDetailsPage(
                                    name: snap['Product Name'],
                                    uid: snap['uid'],
                                    bidlength: bid,
                                    bid: snap['Minimum Bid'],
                                    imageUrl: snap['Product pic'],
                                    postId: snap['postId'],
                                    details: snap['Product Details'],
                                    rating: snap['rating'],
                                    reviews: snap['reviews'].length,
                                    price: snap['Price'],
                                  );
                                },
                                closedBuilder: (_, __) {
                                  return GestureDetector(
                                    onTap: __,
                                    child: Container(
                                      height: 80,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 84, 83, 83),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                            offset: Offset(5, 7),
                                          )
                                        ],
                                        // border: Border.all(color: Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme ? Colors.white:Colors.black)
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7.4,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 52, 52, 52),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(1),
                                                    topRight:
                                                        Radius.circular(1)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snap['Product pic']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Container(
                                            height: 27,
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    '${snap['Price']}.Rs',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 14,
                                            color: Colors.transparent,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  snap['Product Name']
                                                              .toString()
                                                              .length <
                                                          10
                                                      ? snap['Product Name']
                                                          .toString()
                                                      : snap['Product Name']
                                                          .toString()
                                                          .replaceRange(
                                                              10,
                                                              snap['Product Name']
                                                                  .toString()
                                                                  .length,
                                                              '...'),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Container(
                                            height: 45,
                                            color: Colors.transparent,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  snap['Product Details']
                                                              .toString()
                                                              .length <
                                                          80
                                                      ? snap['Product Details']
                                                          .toString()
                                                      : snap['Product Details']
                                                          .toString()
                                                          .replaceRange(
                                                              77,
                                                              snap['Product Details']
                                                                  .toString()
                                                                  .length,
                                                              '...'),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Text(
                                                      '$bid Bids',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Text(
                                                      '${snap['rating']}.0⭐',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                      });
                }),
            // trends items
            // GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 20,
            //     mainAxisSpacing: 18,
            //     childAspectRatio: 0.7,
            //   ),
            //   itemCount: 10,
            //   itemBuilder: ((context, index) => Container(
            //         color: Colors.pink,
            //         child: Text("$index"),
            //       )),
            // ),
            // end
          ],
        ),
      ),
      // end
    );
  }
}

class TopDealsConst extends StatelessWidget {
  String title = "";
  String image = "";
  TopDealsConst({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 140,
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
              child: Image.asset("images/$image.png", height: 80.0),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}

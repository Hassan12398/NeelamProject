import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/frontend/screens/itmedetails.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchData = "";
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 243, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: ((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      show = true;
                    });
                  } else {
                    setState(() {
                      show = false;
                    });
                  }
                  setState(() {
                    searchData = value;
                  });
                }),
                onSubmitted: ((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      show = true;
                    });
                  } else {
                    setState(() {
                      show = false;
                    });
                  }
                  setState(() {
                    searchData = value;
                  });
                }),
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search',
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
            // result data
            show
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .where(
                          "Product Name",
                          isGreaterThanOrEqualTo: searchData,
                        )
                        .snapshots(),
                    builder: ((context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 30, 76, 106),
                        ));
                      } else if (searchData == "") {
                        return Center(
                          child: Text("Please Search Something!"),
                        );
                      } else {
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            dragStartBehavior: DragStartBehavior.start,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 0.84),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var snap = snapshot.data!.docs[index].data();
                              int bid = snap['bids'].length;
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: OpenContainer(
                                      closedColor: Colors.transparent,
                                      middleColor: Color.fromARGB(255, 0, 0, 0),
                                      openColor: Color.fromARGB(255, 0, 0, 0),
                                      closedShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      openShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      closedElevation: 5.0,
                                      transitionDuration: Duration(
                                        milliseconds: 500,
                                      ),
                                      transitionType:
                                          ContainerTransitionType.fade,
                                      openBuilder: (_, __) {
                                        return ItemDetailsPage(
                                          bidL: snap['bids'],
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
                                          status: snap['bid on'],
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
                                              borderRadius:
                                                  BorderRadius.circular(1),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 84, 83, 83),
                                                  blurRadius: 15,
                                                  spreadRadius: 1,
                                                  offset: Offset(5, 7),
                                                )
                                              ],
                                              // border: Border.all(color: Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme ? Colors.white:Colors.black)
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      7.4,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 52, 52, 52),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(1),
                                                              topRight: Radius
                                                                  .circular(1)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snap[
                                                                  'Product pic']),
                                                          fit: BoxFit.cover)),
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      color: Colors.transparent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Text(
                                                              '${snap['Price']}.Rs',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      color: Colors.transparent,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
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
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(),
                                                Container(
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5),
                                                        child: Text(
                                                          '$bid Bids',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                            });
                      }
                    }))
                : StreamBuilder(
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
                            Center(
                                child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 30, 76, 106),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 18,
                                  childAspectRatio: 0.84),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs[index].data();
                            int bid = snap['bids'].length;
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                    transitionType:
                                        ContainerTransitionType.fade,
                                    openBuilder: (_, __) {
                                      return ItemDetailsPage(
                                        bidL: snap['bids'],
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
                                        status: snap['bid on'],
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
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 84, 83, 83),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                                offset: Offset(5, 7),
                                              )
                                            ],
                                            // border: Border.all(color: Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme ? Colors.white:Colors.black)
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6.8,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 52, 52, 52),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        1),
                                                                topRight: Radius
                                                                    .circular(
                                                                        1)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snap['Product pic']),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        color:
                                                            Colors.transparent,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                '${snap['Price']}.Rs',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 14,
                                                        color:
                                                            Colors.transparent,
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    color: Colors.transparent,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
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
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(),
                                              Container(
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
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                          });
                    }),
            // end
          ],
        ),
      ),
    );
  }
}

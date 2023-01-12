// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container


import 'package:animations/animations.dart';
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
  String title ='Dell Laptop'; 
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
        backgroundColor:Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: (){
               Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          }
        ),
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
            SizedBox(height: 8,),
            GridView.builder(
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child:OpenContainer(
                        closedColor: Colors.transparent,
                        middleColor: Color.fromARGB(255, 0, 0, 0),
                        openColor: Color.fromARGB(255, 0, 0, 0),
                        closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        openShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        closedElevation: 5.0,
                        transitionDuration: Duration(
                          milliseconds: 500,
                        ),
                        transitionType: ContainerTransitionType.fade,
                        openBuilder: (_, __) {
                          return ItemDetailsPage();
                        },
                        closedBuilder: (_, __) {
                          return GestureDetector(
                      onTap: __,
                      child: Container(
                        height: 80,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 84, 83, 83),
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
                              height: MediaQuery.of(context).size.height / 6.8,
                              
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 52, 52, 52),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                     
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://consumer.huawei.com/content/dam/huawei-cbg-site/me-africa/pk/mkt/plp/pc/matebook-x-pro-2021.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              height: 27,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      '170000Rs',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    title.length < 60
                                        ? title
                                        : title.replaceRange(
                                            59, title.length, '...'),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        '10 Bids',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 13),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        '5.0⭐',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                    );}
                    )
                  );
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
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            radius: 60.0,
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

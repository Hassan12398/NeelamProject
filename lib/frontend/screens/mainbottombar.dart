// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_container

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nelaamproject/frontend/screens/chat.dart';

import 'bids.dart';
import 'profile.dart';
import 'selling.dart';
import 'uploading.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int currentPage = 0;
  List<Widget> pages = [
    SellingPage(),
    Container(),
    UploadingPage(),
    BidsPage(),
    PProfilePage(),
  ];
  PageController _pageController =PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => currentPage = index);
          },
          children: [
             SellingPage(),
    chatPage(),
    UploadingPage(),
    BidsPage(),
    PProfilePage(),
          ],
        ),
      ),
      // bottomNavigationBar: GNav(
      //   backgroundColor: Colors.white,
      //   selectedIndex: currentPage,
      //   onTabChange: (value) {
      //     setState(() {
      //       currentPage = value;
      //     });
      //   },
      //   rippleColor: Colors.grey[800]!,
      //   hoverColor: Colors.grey[700]!,
      //   haptic: true,
      //   tabBorderRadius: 25,
      //   curve: Curves.easeOutExpo,
      //   duration: const Duration(milliseconds: 900),
      //   gap: 8,
      //   color: Color.fromARGB(255, 12, 77, 131),
      //   activeColor: Colors.white,
      //   iconSize: 24,
      //   tabBackgroundColor: Colors.green,
      //   tabBackgroundGradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Color.fromARGB(255, 12, 77, 131),
      //       Color.fromARGB(255, 46, 148, 231),
      //     ],
      //   ),
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //   tabs: [
      //     GButton(
      //       icon: CupertinoIcons.house_fill,
      //       text: 'HOME',
      //     ),
      //     GButton(
      //       icon: CupertinoIcons.chat_bubble_text_fill,
      //       text: 'CHAT',
      //     ),
      //     GButton(
      //       icon: CupertinoIcons.cloud_upload_fill,
      //       text: 'UPLOAD',
      //     ),
      //     GButton(
      //       icon: CupertinoIcons.hammer_fill,
      //       text: 'BIDS',
      //     ),
      //     GButton(
      //       icon: CupertinoIcons.person_fill,
      //       text: 'PROFILE',
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentPage,
        items: [
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            title: Text('Home'),
            activeColor:  Color.fromARGB(255, 12, 77, 131),
          ),
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            title: Text('Chat'),
             activeColor:  Color.fromARGB(255, 16, 171, 19),
          ),
            BottomNavyBarItem(
            icon: Icon(CupertinoIcons.camera_fill),
            title: Text('Selling'),
             activeColor:  Color.fromARGB(255, 54, 188, 208),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.gavel_sharp),
            title: Text('Bids'),
             activeColor:  Color.fromARGB(255, 202, 39, 39),
          ),
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            title: Text('Profile'),
             activeColor:  Color.fromARGB(255, 217, 56, 212),
          )
        ],
        onItemSelected: (value) {
          setState(() {
            currentPage = value;
               _pageController.animateToPage(value,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nelaamproject/backend/auth/authFunctions.dart';
import 'package:nelaamproject/drawer/sellingitem.dart';
import 'package:nelaamproject/frontend/screens/mainbottombar.dart';
import 'package:nelaamproject/frontend/screens/selling.dart';
import 'package:nelaamproject/frontend/screens/welcome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
          // options: FirebaseOptions(
          //     apiKey: "AIzaSyB4bbS4zXC8eX_YW9DZ8S6s69Hxau7muNk",
          //     projectId: "chatapp-fde18",
          //     messagingSenderId: "1001240436735",
          //     appId: "1:1001240436735:web:17e9a30bfbccfd42d391ca")
              )
      .then((value) => Get.put(AuthFunction()));
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:  Color.fromARGB(255, 30, 76, 106),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Brightness.dark,
    ));
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.lightBlue,
      //   appBarTheme: AppBarTheme(color:Color.fromARGB(255, 30, 76, 106))
      //   // scaffoldBackgroundColor: Color.fromARGB(255, 30, 76, 106),
      //   // useMaterial3: true,
        
      // ),
      theme:ThemeData.light().copyWith(
        primaryColor:  Color.fromARGB(255, 30, 76, 106),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        centerTitle: false, backgroundColor: kPrimaryColor),
    // iconTheme: IconThemeData(color: Colors.wh),
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 30, 76, 106),
      secondary: Colors.orange,
      error: Colors.red,
    ),
      ),
      scrollBehavior: const CupertinoScrollBehavior(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainBottomBar();
            } else {
              return WelcomePage();
            }
          }),
    );
  }
}


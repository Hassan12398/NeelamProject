import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nelaamproject/backend/imagedata.dart';
import 'package:uuid/uuid.dart';

Future prodcutUpload(
  String productName,
  String details,
  String price,
  String bid,
  String categories,
  String imageUrl,
) async {
  var uuid = Uuid();
  var id = uuid.v1();
  try {
    
    await FirebaseFirestore.instance.collection("Products").doc(id).set({
      "Product Name": productName,
      "Product Details": details,
      "Price": price,
      "Minimum Bid": bid,
      "Categories": categories,
      "Product pic": imageUrl,
      "bids":[],
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "postId":id,
      "rating":0,
      "reviews":[],
    });
  } catch (e) {
    print(e);
  }
}
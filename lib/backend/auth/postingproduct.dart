import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nelaamproject/backend/imagedata.dart';
import 'package:uuid/uuid.dart';

Future prodcutUpload(
  String productName,
  String details,
  String price,
  String bid,
  String categories,
  Uint8List image,
) async {
  var uuid = Uuid();
  var id = uuid.v1();
  try {
    String imageUrl = await ImageUpload().uploadImage(image);
    await FirebaseFirestore.instance.collection("Products").doc(id).set({
      "Product Name": productName,
      "Product Details": details,
      "Price": price,
      "Minimum Bid": bid,
      "Categories": categories,
      "Product pic": imageUrl,
    });
  } catch (e) {
    print(e);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nelaamproject/Widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

CreateProductChatRoom(String uid, name1, name2, String prof1, String prof2,
    String product, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Chatrooms')
        .doc(uid)
        .set({
      'uid': uid,
      'lastMessage': '',
      'read': false,
      'username': name2,
      'profileImage': prof2,
      'time': DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Chatrooms')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'username': name1,
      'read': false,
      'lastMessage': '',
      'profileImage': prof1,
      'time': DateTime.now(),
    });

    String postId = Uuid().v1();
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Chatrooms')
        .doc(uid)
        .collection('messages')
        .doc(postId)
        .set({
      'message': 'Hi I want to buy this $product product',
      'chatId': uid,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'name': name1,
      'read': false,
      'type': 'text',
      'time': DateTime.now(),
      'postId': postId,
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Chatrooms')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(postId)
        .set({
      'message': 'Hi I want to buy this $product product',
      'chatId': uid,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'read': false,
      'name': name1,
      'type': 'text',
      'time': DateTime.now(),
      'postId': postId,
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Chatrooms')
        .doc(uid)
        .update({'lastMessage': ''});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Chatrooms')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'lastMessage': 'buy now'});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Chatrooms')
        .doc(uid)
        .update({'time': DateTime.now()});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Chatrooms')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'time': DateTime.now()});
  } catch (e) {
    Showsnackbar(context, e.toString());
  }
}

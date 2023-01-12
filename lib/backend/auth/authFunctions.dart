import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nelaamproject/Widgets/snackbar.dart';
Color kPrimaryColor = Colors.lightBlue.shade900;
class AuthFunction extends GetxController {
  static AuthFunction instance = Get.find();

  Future<String> Signup(String email, String password, String username,
      BuildContext context) async {
    String err = '';
    try {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Creating Account', 'Success',
          overlayColor: kPrimaryColor,
          backgroundColor: kPrimaryColor.withOpacity(1),
          colorText: Colors.white);

      String? descc;
      // model.User user = model.User(
      //   bio: 'Hey there Iam using HN Chat App',
      //   verify: 'None',
      //   email: email,
      //   username: username,
      //   uid: cred.user!.uid,
      //   statusT: DateTime.now(),
      //   typing: '',
      //   status: 'unavailable',
      //   photoUrl:
      //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU',
      // );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
            'username':username,
            'password':password,
            'email':email,
            'profileUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhW0hzwECDKq0wfUqFADEJaNGESHQ8GRCJIg&usqp=CAU',
            'posts':[],
            'status':'unavailable',
            'statusT':DateTime.now(),
            'uid':cred.user!.uid,
            'verify':false,
            'rating':0,
            'response':'good',
          });
      // Get.to(homePgae(), transition: Transition.rightToLeft);
      if (password.isEmpty && username.isEmpty && email.isEmpty) {
        err = 'fields-error';
        Showsnackbar(context, 'Please fill all fields');
      }
    } on FirebaseAuthException catch (e) {
      Showsnackbar(context, e.message!);
      print(e.code);
      if (e.code == 'weak-password') {
        err = "password-error";

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        err = "email-error";
      } else if (e.code == 'invalid-email') {
        err = "invalid-email";
      } else if (e.code == 'unknown') {
        err = "fields-error";
      } else if (e.code == 'network-request-failed') {
        err = "network-error";
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
      // Get.snackbar('Error in Creating Account', e.toString(),
      //     overlayColor: Colors.purple,
      //     backgroundColor: Colors.purple.shade200,
      //     colorText: Colors.white);
    }
    return err;
  }

  Future<String> loginUser(
      String email, String password, BuildContext context) async {
    String err2 = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Login done");
      // Get.to(homePgae(), transition: Transition.rightToLeft);

      // Get.snackbar('Error', 'Please Fill All Fields',
      //     overlayColor: Colors.purple,
      //     backgroundColor: Colors.purple.shade200,
      //     colorText: Colors.white);

    } on FirebaseAuthException catch (e) {
      Showsnackbar(context, e.message!);
      print(e.code);
      if (e.code == 'user-not-found') {
        err2 = 'error-user';
      } else if (e.code == 'wrong-password') {
        err2 = 'error-pass';
      } else if (e.code == 'invalid-email') {
        err2 = "invalid-email";
      } else if (e.code == 'unknown') {
        err2 = "fields-error";
      } else if (e.code == 'network-request-failed') {
        err2 = "network-error";
      } else if (e.code == 'too-many-requests') {
        err2 = "network-error";
      }
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return err2;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await this.googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // model.User user2 = model.User(
          //   bio: 'Hey there Iam using HN Chat App',
          //   verify: 'None',
          //   email: user.email,
          //   username: user.displayName,
          //   uid: user.uid,
          //   statusT: DateTime.now(),
          //   status: 'unavailable',
          //   typing: '',
          //   photoUrl: user.photoURL,
          // );
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                 'username':user.displayName,
            // 'password':password,
            'email':user.email,
            'profileUrl': user.photoURL,
            'posts':[],
            'status':'unavailable',
            'statusT':DateTime.now(),
            'uid':user.uid,
            'verify':false,
            'rating':0,
            'response':'good',
              });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      Showsnackbar(context, e.message!);
      res = false;
    } catch (e) {
      Showsnackbar(context, e.toString());
      res = false;
    }
    return res;
  }

  Future<bool> logout() async {
    try {
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .update({
      //   'status': 'Offline',
      //   'statusT': DateTime.now(),
      // });
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      return true;
    } catch (e) {}
    return false;
  }
}

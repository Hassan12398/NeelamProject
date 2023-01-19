// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nelaamproject/frontend/screens/editProduct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SellingItemPage extends StatefulWidget {
  const SellingItemPage({super.key});

  @override
  State<SellingItemPage> createState() => _SellingItemPageState();
}

class _SellingItemPageState extends State<SellingItemPage> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 76, 106),
      // appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        centerTitle: true,
        shadowColor: Colors.white,
        elevation: 5.0,
        title: Text(
          "Selling",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // end
      body: SingleChildScrollView(
        child: Column(
          children: [
            // bar
            Container(
              height: 6.0,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 40.0),
            // item list
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where(
                    "uid",
                    isEqualTo: uid,
                  )
                  .snapshots(),
              builder: ((context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return ItemsForSellConst(
                              productData: snapshot.data!.docs[index]);
                        })),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemsForSellConst extends StatefulWidget {
  var productData;
  ItemsForSellConst({
    required this.productData,
  });

  @override
  State<ItemsForSellConst> createState() => _ItemsForSellConstState();
}

class _ItemsForSellConstState extends State<ItemsForSellConst> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              icon: Icons.delete_outline_outlined,
              backgroundColor: Colors.red,
              onPressed: ((context) {
                Alert(
                  context: context,
                  title: "Are you sure to delete this post ?",
                  desc:
                      "This post will be delete permanently and you cannot restore it. Agree?",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Cancle",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                    ),
                    DialogButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("Products")
                            .doc(widget.productData["postId"])
                            .delete()
                            .then(
                              (value) => Navigator.pop(context),
                            );
                      },
                      color: Colors.red,
                    ),
                  ],
                ).show();
              }),
            ),
            SlidableAction(
              icon: Icons.edit_outlined,
              backgroundColor: Colors.blue,
              onPressed: ((context) async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProduct(prodata: widget.productData),
                  ),
                );
              }),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: 180.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // data
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.productData["Product Name"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.productData["Categories"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Price : ${widget.productData["Price"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Minimum Bid : ${widget.productData["Minimum Bid"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Bids : ${widget.productData["bids"].length}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Rating : ${widget.productData["rating"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // image
              Container(
                height: 180.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      topRight: Radius.circular(4)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.productData["Product pic"],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

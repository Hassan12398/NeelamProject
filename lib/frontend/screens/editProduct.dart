import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
import 'package:flutter_switch/flutter_switch.dart';

class EditProduct extends StatefulWidget {
  dynamic prodata;
  EditProduct({
    required this.prodata,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String pname = "";
  String pdetails = "";
  String pprice = "";
  String pmbid = "";
  String postId = "";
  bool loading = false;
  bool status = true;
  @override
  void initState() {
    storeValues();
    super.initState();
  }

  void storeValues() {
    setState(() {
      pname = widget.prodata["Product Name"];
      pdetails = widget.prodata["Product Details"];
      pprice = widget.prodata["Price"];
      pmbid = widget.prodata["Minimum Bid"];
      postId = widget.prodata["postId"];
      productname.text = pname;
      productdetails.text = pdetails;
      productprice.text = pprice;
      productminbid.text = pmbid;
      status = widget.prodata["bid on"];
    });
  }

  TextEditingController productname = TextEditingController();
  TextEditingController productdetails = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productminbid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 76, 106),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Edit Your Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.0),
              Text(
                "Product Name :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextField(
                  controller: productname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: pname,
                  ),
                ),
              ),
              Text(
                "Product Details :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextField(
                  controller: productdetails,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: pdetails,
                  ),
                ),
              ),
              Text(
                "Price :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextField(
                  controller: productprice,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: pprice,
                  ),
                ),
              ),
              Text(
                "Minimum Bid :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextField(
                  controller: productminbid,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: pmbid,
                  ),
                ),
              ),
              SizedBox(height: 14.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bid on/off",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 26, 69, 145),
                        fontSize: 18.0,
                      ),
                    ),
                    FlutterSwitch(
                      width: 70.0,
                      height: 40.0,
                      value: status,
                      activeColor: Color.fromARGB(255, 26, 69, 145),
                      onToggle: (value) {
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              loading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ));
                        await FirebaseFirestore.instance
                            .collection("Products")
                            .doc(postId)
                            .update({
                          "Product Name": productname.text,
                          "Product Details": productdetails.text,
                          "Price": productprice.text,
                          "Minimum Bid": productminbid.text,
                          "bid on": status,
                        }).then(
                          (value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Container(
                        height: 55.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              spreadRadius: 4.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            "Edit Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 26, 69, 145),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
              // end
            ],
          ),
        ),
      ),
    );
  }
}

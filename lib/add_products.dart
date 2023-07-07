import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _productNamecontroller = TextEditingController();
  final TextEditingController _availableQuantitycontroller =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  post_products() async {
    Future.delayed(const Duration(seconds: 0), () {
      AlertDialog alert = AlertDialog(
        content: Row(children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.teal,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ]),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });

    var url = Uri.parse("https://uiexercise.onemindindia.com/api/Product");
    var data = {
      'productName': _productNamecontroller.text,
      'availableQuantity': int.parse(_availableQuantitycontroller.text),
    };

    var response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Add Prodcuts"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(

                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes the shadow position
                          ),
                        ],
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _productNamecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Product Name',

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes the shadow position
                          ),
                        ],
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _availableQuantitycontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Available Quantity ',

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          post_products();
                        }
                      },
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

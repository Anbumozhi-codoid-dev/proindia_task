import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'add_products.dart';
import 'model.dart';
import 'order_success.dart';

class List_Product extends StatefulWidget {
  const List_Product({super.key});

  @override
  State<List_Product> createState() => _List_ProductState();
}

class _List_ProductState extends State<List_Product> {
  List<Product> ProductList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }

  order_product(productid, int quantity, productname) async {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
        const CircularProgressIndicator(
          backgroundColor: Colors.teal,
        ),
        Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
      ]),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    var url =
        Uri.parse("https://uiexercise.onemindindia.com/api/OrderProducts");
    var data = {
      "orderId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "customerId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "productId": productid,
      "quantity": quantity
    };
    print(data);
    print(data.runtimeType);
    print(jsonEncode(data).runtimeType);
    var response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    print('response.statusCode');
    Navigator.pop(context);
    if (response.statusCode.toString() == '200') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => order_success_screen(
                  productName: productname,
                )),
      );
    }
    print(response.statusCode);
  }

  getproduct() async {
    Future.delayed(Duration(seconds: 0), () {
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

    try {
      var url = Uri.parse("https://uiexercise.onemindindia.com/api/Product");

      var response = await http.get(url);

      var JsonResponse = jsonDecode(response.body);
      print(jsonDecode(response.body));
      for (int i = 0; i < JsonResponse.length; i++) {
        ProductList.add(Product.fromJson(JsonResponse[i]));
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return
            SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  title: const Text('Products List'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      iconSize: 20,
                      tooltip: 'Add Products',
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddProducts()),
                        );
                      },
                    ),
                  ],
                ),
                body: ListView.builder(
                    itemCount: ProductList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product ref = ProductList[index];
                      return ref.productName != "null"?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.teal[100],
                          //   borderRadius: BorderRadius.circular(8),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.grey.withOpacity(0.5),
                          //       spreadRadius: 2,
                          //       blurRadius: 5,
                          //       offset: const Offset(0, 3), // changes the shadow position
                          //     ),
                          //   ],
                          // ),
                          child:
                          ListTile(
                            title:

                            SizedBox(
                              height: 10.h,
                              child: Card(
                                elevation: 1,
                                  color: Colors.teal[100],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Product: ${ref.productName}'),
                                      Text('Available Quantity: ${ref.availableQuantity}')
                                    ],
                                  )),
                            ),
                            // subtitle:
                            // Text('Available Quantity: ${ref.availableQuantity}'),
                            trailing: SizedBox(
                              height: 10.h,
                              child: Card(
                                elevation: 1,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal[100], // Background color
                                  ),
                                  onPressed: () {
                                    order_product(ref.productId, ref.availableQuantity,
                                        ref.productName);
                                  },
                                  child: const Text('order',style: TextStyle(color: Colors.black54)),
                                ),
                              ),
                            ),
                          )
                        ),
                      )
                          :
                          SizedBox();
                    }),
              ),
            );

  }
}

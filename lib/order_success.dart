import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class order_success_screen extends StatelessWidget {
  final String productName;
  order_success_screen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20.h,
              width: 50.w,
              child:  Card(
                  elevation: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 10.h,
                          width: 10.w,
                          child: Image.asset("asset/greenTickIcon.png")),
                      const Text('Order placed successfully!!!',
                      style: TextStyle(color: Colors.teal),),
                      Text("Product Name : $productName",
                        style: const TextStyle(color: Colors.teal),),
                    ],
                  )),
            ),


          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app/apis/apis.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> fetchProducts() async {
      var products = await ProductsApis().getAllProducts();
      return products;
    }

    var products = fetchProducts();
    return Scaffold(
      appBar: const AppHeader(title: "home"),
      drawer: const AppDrawer(),
      body: Container(
        margin: const EdgeInsets.all(20),
        // height:MediaQuery.of(context).size.height*0.3,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last production:"+"--"),
                Text("Date:"+"--"),
                Text("Quantity:"+"--")

          ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Last purchase:" + "--"),
                Text("Date:" + "--"),
                Text("Status:" + "--")
              ]),

              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("product 1" + "--"),
              Text("product 2" + "--"),
              Text("product 3" + "--")
            ]),
          ],
        ),
      ),
      
    );
  }
}

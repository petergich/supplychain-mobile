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
      var products = await const ProductsApis().getAllProducts();
      return products;
    }

    var raw = fetchProducts();
    var products = raw;
    return Scaffold(
      appBar: const AppHeader(title: "home"),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color.fromARGB(255, 113, 219, 255),
        padding: const EdgeInsets.all(16),
        child: Column(
          // height:MediaQuery.of(context).size.height*0.3,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color.fromARGB(176, 165, 111, 49),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(179, 230, 144, 46),
                    ),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Last production:" + "--"),
                          Text("Date:" + "--"),
                          Text("Quantity:" + "--")
                        ]),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color.fromARGB(179, 230, 144, 46),
                      ),
                      child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Last purchase:" + "--"),
                            Text("Date:" + "--"),
                            Text("Status:" + "--")
                          ])),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color.fromARGB(179, 230, 144, 46),
                      ),
                      child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Low Stock Products"),
                            Text("product 1 quantity: 0"),
                            Text("product 2 quantity: 0"),
                            Text("product 3 quantity: 0"),
                          ])),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            const SizedBox(height: 20),
            const Text("Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color.fromARGB(179, 243, 125, 15),
              ),
              child:
                FutureBuilder(
                future:const ProductsApis().getAllProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  /// Depending on the state of our future,
                  /// we return the appropriate ui elements
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text("${snapshot.data}");
                  }
                },
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}

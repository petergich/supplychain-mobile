import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/apis/authenticationapis/login_apis.dart';
import 'package:test_app/apis/products/productapis.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/products.dart';
import 'package:test_app/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<bool> _isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    _isLoggedInFuture = LoginApis().isLoggedIn();
    // We need to check the login status in the build method.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedInFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          });
          return const SizedBox.shrink(); // Return an empty widget while navigating
        }

        final screenSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: const AppHeader(title: "home"),
          drawer: const AppDrawer(),
          body: Container(
            color: const Color.fromARGB(255, 113, 219, 255),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(176, 165, 111, 49),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color.fromARGB(179, 230, 144, 46),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ]),
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
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Low Stock Products"),
                                Text("product 1 quantity: 0"),
                                Text("product 2 quantity: 0"),
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
                      fontSize: 24,
                      color: Color.fromARGB(255, 68, 41, 13),
                      fontFamily: 'Times New Roman',
                    )),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: Get.width,
                  height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(179, 249, 138, 34),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: FutureBuilder(
                    future: const ProductsApis().getAllProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return Column(
                          children: [
                            const Row(
                              children: [
                                Expanded(flex: 2, child: Text("")),
                                Expanded(
                                  flex: 2,
                                  child: Text("Product",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 60, 14, 225))),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Text("Category",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                            Color.fromARGB(255, 60, 14, 225)))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                            Color.fromARGB(255, 60, 14, 225)))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Quantity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                            Color.fromARGB(255, 60, 14, 225)))),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 3,
                            ),
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 186, 110, 43),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                height: screenSize.height * 0.4,
                                child: Scrollbar(
                                    thumbVisibility: true,
                                    child: ListView(
                                      children: snapshot.data!
                                          .map((e) => Column(children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                                flex: 2,
                                                child: Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Color.fromARGB(
                                                      255, 66, 35, 2),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${e['name']}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 66, 35, 2)),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${e['category']["name"]}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 66, 35, 2)),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${e['price']}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 66, 35, 2)),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${e['quantity']}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 66, 35, 2)),
                                                )),
                                          ],
                                        ),
                                        const Divider(
                                          color: Color.fromARGB(
                                              255, 59, 59, 59),
                                          thickness: 1,
                                        ),
                                      ]))
                                          .toList(),
                                    )))
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

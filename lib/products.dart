import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppHeader(title: "Products"),
        drawer: AppDrawer(),
        body: Center(
          child: Text("This is the product page"),
        ));
  }
}

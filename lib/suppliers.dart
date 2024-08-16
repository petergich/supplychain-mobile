import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({Key? key}) : super(key: key);
  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(title: "Suppliers"),
        drawer: AppDrawer(),
        body: Container(
          child: Text("Suppliers page"),
        ));
  }
}

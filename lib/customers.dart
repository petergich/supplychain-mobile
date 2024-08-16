import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(title: "Customers"),
        drawer: AppDrawer(),
        body: Container(
          child: Text("Customers page"),
        ));
  }
}

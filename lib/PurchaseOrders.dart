import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({Key? key}) : super(key: key);
  @override
  _PurchaseOrderState createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Purchase Orders"),
      drawer: AppDrawer(),
      body: Container(
        child: Text("You are in the home page"),
      ),
    );
  }
}

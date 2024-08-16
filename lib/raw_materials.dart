import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class RawMaterials extends StatefulWidget {
  const RawMaterials({Key? key}) : super(key: key);

  @override
  _RawMaterialsState createState() => _RawMaterialsState();
}

class _RawMaterialsState extends State<RawMaterials> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppHeader(title: "Raw Materials"),
        drawer: AppDrawer(),
        body: Center(
          child: Text("This is the raw materials page"),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/home.dart';
import 'package:test_app/products.dart';

void main() {
  runApp(const SupplyChainApp());
}

class SupplyChainApp extends StatelessWidget {
  const SupplyChainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: Home());
  }
}

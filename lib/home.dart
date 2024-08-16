import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: "home"),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Welcome to the Home page!'),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:const AppHeader(title: "Admin"),
        drawer:const AppDrawer(),
        body: Container(
          child: Text('You are in the admin page'),
        ));
  }
}

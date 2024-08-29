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

  // void checkLoginStatus(){
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:const AppHeader(title: "Admin"),
        drawer:const AppDrawer(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,


          decoration: const BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: Container(
            margin:const EdgeInsets.all(20),
              child:const Text("Admin page") ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/apis/api_services.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({Key? key}) : super(key: key);

  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Suppliers"),
      drawer: const AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
        ),

          child: Column(
            children: [
              const Text(
                "Suppliers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 254, 254, 254),
                    ),
                  ],
                  fontSize: 24,
                  color: Color.fromARGB(255, 10, 0, 13),
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 10), // Add spacing between header and list
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: ApiServices().getSuppliers(),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          const Divider(color: Color.fromRGBO(0, 0, 0, 1)),
                          const SizedBox(height: 20),
                          Text("${snapshot.error}"),
                        ],
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 1,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                            child:const Row(
                            children: [
                              Expanded(flex: 2, child: Text("Name", style: TextStyle(color: Colors.black,fontSize: 24))),
                              Expanded(flex: 2, child: Text("Phone", style: TextStyle(color: Colors.black,fontSize: 24))),
                              Expanded(flex: 2, child: Text("Location", style: TextStyle(color: Colors.black,fontSize: 24))),
                            ],
                          ),),
                          SizedBox(height: 10,),
                          Expanded(
                            child: ListView(
                              children: snapshot.data!.map((item) => Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(item["name"] ?? "N/A")),
                                      Expanded(flex: 2, child: Text(item["phone"] ?? "N/A")),
                                      Expanded(flex: 2, child: Text(item["location"] ?? "N/A")),
                                    ],
                                  ),
                                  // Optional divider for separation
                                ],
                              )).toList(),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text("No data available"));
                    }
                  },
                ),
              ),
            ],
          ),

      ),
    );
  }
}

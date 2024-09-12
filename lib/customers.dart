import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_controller/form_controller.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/apis/api_services.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
 int _selectedIndex = -1;
  late Future<List<dynamic>> _suppliersFuture;
  // Function to handle row click
  void _onRowTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void initState(){
    super.initState();
   
  }
  void _refreshSuppliers() {
    setState(() {
      _suppliersFuture = ApiServices().getSuppliers();
     // Re-fetch the suppliers
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Customers"),
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
            const Row(children:[
              Icon(Icons.people),
              Text(
              "Customers",
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
            ),]),
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
                          child: const Row(
                            children: [
                              Expanded(flex: 2, child: Text("Name", style: TextStyle(color: Colors.black, fontSize: 24))),
                              Expanded(flex: 2, child: Text("Phone", style: TextStyle(color: Colors.black, fontSize: 24))),
                              Expanded(flex: 2, child: Text("Location", style: TextStyle(color: Colors.black, fontSize: 24))),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final item = snapshot.data![index];
                              return GestureDetector(
                                onTap: () =>{
                                  _onRowTapped(index),
                                  show_supplier_dialog(item["id"]),
                                },
                                child: Container(
                                  color: _selectedIndex == index ? Colors.blue : Colors.grey[200],
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(item["name"] ?? "N/A")),
                                      Expanded(flex: 2, child: Text(item["phone"] ?? "N/A")),
                                      Expanded(flex: 2, child: Text(item["location"] ?? "N/A")),
                                    ],
                                  ),
                                ),
                              );
                            },
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
  void show_supplier_dialog(id){
    showDialog(context: context, builder: (BuildContext context){
      return  AlertDialog(
        title: Text("Actions"),
        content: Row(
          children: [
            ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).pop();
                  FutureBuilder<String>(
                    future:ApiServices().deleteSupplier(id),
                    builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }
                      else if(snapshot.hasError){

                        return AlertDialog(
                          title: const Text("Message"),
                          content: Text("${snapshot.error}"),
                        );


                    }
                      else{
                        _refreshSuppliers();
                        return AlertDialog(
                          title: const Text("Success"),
                          content: Text(snapshot.data!),
                        );
                      }
      }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255,254,0,0),
                  foregroundColor: Colors.white
                ),
                icon: const Icon(Icons.delete),
                label:const Text("delete")),
            const SizedBox(width: 10,),
            ElevatedButton.icon(onPressed: (){
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return  AlertDialog(
                      title: Text("Edit Supplier",textAlign: TextAlign.center,),
                      content: Container(
                        child: FormBuilder(child: Container(
                          child: Column(
                              children:[
                                Divider(height: 2,color: Colors.black,),
                                SizedBox(height: 20,),
                                
                                FormBuilderTextField(
                                  name: "name",
                               
                               
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "name"
                                ),),
                                 FormBuilderTextField(
                                  name: "Location",
                               
                               
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Location"
                                ),),
                                
                              ]),
                              

                        )),
                      ),
                    );
              });
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white
                ),
                icon: const Icon(Icons.edit),
                label:const Text("edit")),
          ],
        ),
      );
    });
  }
}


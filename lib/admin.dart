import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/apis/authenticationapis/login_apis.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/apis/api_services.dart';



class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}
class _AdminState extends State<Admin> {
  int _selectedIndex = -1;
  late Future<List<dynamic>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = ApiServices().getUsers();
  }

  void _refreshData() {
    setState(() {
      _usersFuture = ApiServices().getUsers();
    });
  }

  void _onRowTapped(int index, bool status, int id) {
    setState(() {
      _selectedIndex = index;
      _showUserDialog(id, status);
    });
  }

  void _showUserDialog(int index, bool status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Actions", textAlign: TextAlign.center),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  _changeUserStatus(index);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: status ? Colors.blue : Colors.blue,
                  foregroundColor: Colors.white,
                ),
                icon: Icon(status ? Icons.block_rounded : Icons.verified),
                label: Text(status ? "Deactivate" : "Activate"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement delete functionality here
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _changeUserStatus(int index) async {
    try {
      final response = await LoginApis().changeUserStatus(index);
      _showResponseDialog("Message", response);
      _refreshData();  // Refresh data after successful change
    } catch (error) {
      _showResponseDialog("Error", error.toString());
    }
  }

  void _showResponseDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Admin"),
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
            const Row(
              children: [
                Icon(Icons.verified_user),
                Text(
                  "Users",
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
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _usersFuture,
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
                              Expanded(flex: 2, child: Text("Username", style: TextStyle(color: Colors.black, fontSize: 24))),
                              Expanded(flex: 3, child: Text("Email", style: TextStyle(color: Colors.black, fontSize: 24))),
                              Expanded(flex: 1, child: Text("Status", style: TextStyle(color: Colors.black, fontSize: 24))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final item = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  _onRowTapped(index, item["accountApproved"], item["id"]);
                                },
                                child: Container(
                                  color: _selectedIndex == index ? const Color.fromARGB(255, 131, 187, 234) : Colors.grey[200],
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(item["username"] ?? "N/A")),
                                      Expanded(flex: 3, child: Text(item["email"] ?? "N/A")),
                                      Expanded(flex: 1, child: Text(item["accountApproved"] ? "Active" : "Inactive")),
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
}

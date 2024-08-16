import 'package:flutter/material.dart';
import 'package:test_app/PurchaseOrders.dart';
import 'package:test_app/admin.dart';
import 'package:test_app/customers.dart';
import 'package:test_app/home.dart';
import 'package:test_app/products.dart';
import 'package:test_app/raw_materials.dart';
import 'package:test_app/suppliers.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(135, 214, 118, 0),
              ),
              child: Text(
                'Supply Chain',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Row(children:[
              Icon(
                Icons.home
              ),
              Text("Home")
            ]),
            onTap: () {
              // Handle home tap
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
            },
          ),
          ListTile(
            title: const Row(children:[
              Icon(
                Icons.add_shopping_cart
              ),
              Text("Products")
            ]),
            onTap: () {
              // Handle item 2 tap
             Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>const  Products()));
              // Close the drawer
            },
          ),
          ListTile(
            title: const Row(children:[
              Icon(
                Icons.receipt
              ),
              Text("Purchase Orders")
            ]),
            onTap: () => {
              //Handling the tap
              Navigator.push(context, MaterialPageRoute(builder: ((context) =>const PurchaseOrder()))),
            },
          ),
          ListTile(
            title: const Row(children:[
              Icon(
                Icons.factory_outlined
              ),
              Text("Suppliers")
            ]),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const Suppliers()))
            },
          ),
          ListTile(
            title: const Row(children:[
              Icon(
                Icons.people
              ),
              Text("Customers")
            ]),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const Customers()))
            },
          ),
                    ListTile(
            title: const Row(children:[
              Icon(
                Icons.pallet
              ),
              Text("Raw Materials")
            ]),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const RawMaterials()))
            },
          ),

           ListTile(
            title: const Row(children:[
              Icon(
                Icons.admin_panel_settings
              ),
              Text("Admin")
            ]),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const Admin()))
            },
          )

          // Add more ListTile widgets here for additional menu items
        ],
      ),
    );
  }
}

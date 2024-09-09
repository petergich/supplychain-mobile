import 'package:form_controller/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_app/apis/authenticationapis/login_apis.dart';
import 'package:test_app/apis/products/productapis.dart';
import 'package:test_app/app_drawer.dart';
import 'package:test_app/app_header.dart';
import 'package:test_app/login.dart';
import 'package:dropdown_search/dropdown_search.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FormController addProductController;
  late Future<bool> _isLoggedInFuture;
  late TextEditingController categoryNameController;
  String category = '';
  String categoryName = '';
  String categoryError = '';

  @override
  void initState() {
    super.initState();
    addProductController = FormController();
    categoryNameController = TextEditingController();
    _isLoggedInFuture = LoginApis().isLoggedIn();
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedInFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          });
          return const SizedBox.shrink(); // Return an empty widget while navigating
        }

        final screenSize = MediaQuery.of(context).size;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const AppHeader(title: "Home"),
          drawer: const AppDrawer(),
          body: Container(
            color: const Color.fromARGB(255, 113, 219, 255),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCards(),
                const Divider(color: Colors.grey, thickness: 2),
                const SizedBox(height: 20),
                _buildProductList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCards() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusCard(
            title: "Last Production",
            content: "Date: --\nQuantity: --",
            color: const Color.fromARGB(255, 255, 223, 186),
          ),
          _buildStatusCard(
            title: "Low Stock Products",
            content: "Product 1 quantity: 0\nProduct 2 quantity: 0",
            color: const Color.fromARGB(255, 255, 223, 186),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 240, 200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color.fromARGB(255, 68, 41, 13),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: ProductsApis().getAllProducts(),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No products available.");
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4, // Example height, adjust as needed
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      children: snapshot.data!
                          .map((e) => _buildProductRow(e))
                          .toList(),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    addProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text("Add Product"),
                  icon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    addCategoryModal(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text("Add Category"),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(Map<String, dynamic> product) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.brown,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${product['name']}",
              style: const TextStyle(
                color: Colors.brown,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${product['category']['name']}",
              style: const TextStyle(
                color: Colors.brown,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${product['price']}",
              style: const TextStyle(
                color: Colors.brown,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${product['quantity']}",
              style: const TextStyle(
                color: Colors.brown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCategoryModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 230, 230, 250),
          title: const Text("Add New Category"),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category name..',
                  ),
                ),
                Text(
                  categoryError,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (categoryNameController.text.isNotEmpty) {
                      Navigator.of(context).pop();
                      addCategory();
                    } else {
                      setState(() {
                        categoryError = 'Category name cannot be empty';
                      });
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addCategory() async {
    String response = await const ProductsApis().createCategory(categoryNameController.text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Response"),
          content: Text(response),
        );
      },
    );
  }

  void addProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 210, 210, 250),
          title: const Text("Add New Product"),
          content: FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Name"),
                FormBuilderTextField(
                  name: "product_name",
                  controller: addProductController.controller("product_name"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Product name",
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Price"),
                FormBuilderTextField(
                  name: "product_price",
                  controller: addProductController.controller("product_price"),
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Price",
                    fillColor: Color.fromARGB(255, 230, 230, 254),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Category"),
                FutureBuilder<List<String>>(
                  future: ProductsApis().getAllCategories(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("No categories available.");
                    } else {
                      return DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          disabledItemFn: (String s) => s.startsWith('Select category'),
                        ),
                        items: snapshot.data!,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Categories",
                            hintText: "Product Categories",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            category = value!;
                          });
                        },
                        selectedItem: "Select category",
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (addProductController.value("product_name").isNotEmpty &&
                        addProductController.value("product_price").isNotEmpty &&
                        category.isNotEmpty) {
                      Navigator.of(context).pop();
                      _addProduct();
                    } else {
                      _showMessage(context, "Error", "Ensure all fields are filled");
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addProduct() async {
    String response = await const ProductsApis().createProduct(
      name: addProductController.value("product_name"),
      price: int.parse(addProductController.value("product_price")),
      category: category,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message"),
          content: Text(response),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showMessage(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }
}

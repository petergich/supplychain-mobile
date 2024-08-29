import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/variables.dart';

final domain = Variables().domain;
var products = [];

class ProductsApis {
  const ProductsApis();

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final url = "$domain/products/all";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print("fetch completed");
      // print(responseBody);

      // Parse the JSON response
      final List<dynamic> productsJson = responseBody['products'];
      // Convert to List<Map<String, dynamic>>
      final List<Map<String, dynamic>> products =
      productsJson.map((json) => json as Map<String, dynamic>).toList();
      // print(products);
      return products;
    } else {
      throw Exception("Error occurred while trying to fetch");
    }
  }

  Future<String> createCategory(String name) async {
    var domain = Variables().domain;
    final response = await http.post(
        Uri.parse('$domain/categories/create'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
        }));

    if (response.statusCode == 200) {
      return "successful";
    }
    else {
      return "Unable to create";
    }
  }

  Future<List<String>> getAllCategories() async {
    final URL = '$domain/categories/all';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      List<dynamic> categoriesJson = responseBody["categories"];
      List<String> categories = [];
      for (int i = 0; i < categoriesJson.length; i++) {
        categories.add(categoriesJson[i]["name"]);
      }
      return categories;
    } else {
      throw Exception("Unable to fetch Categories");
    }
  }

  Future<String> createProduct({required String name, required num price, required String category}) async {
    try {
      final response = await http.post(
          Uri.parse("$domain/products/create"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "price": price,
            "category": category,
          })
      );

      final responseBody = jsonDecode(response.body);
      return responseBody["status"];
    } catch (e) {
      return e as Future<String>;
    }
  }

}

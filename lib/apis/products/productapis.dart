import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const domain = "http://192.168.254.34:8080";
var products = [];

class ProductsApis {
  const ProductsApis();
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    const url = "$domain/products/all";
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
}

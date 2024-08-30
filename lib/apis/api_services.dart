import 'dart:convert';

import 'package:test_app/variables.dart';
import 'package:http/http.dart' as http;
final domain = Variables().domain;


class ApiServices{
  Future<List<dynamic>> getSuppliers() async{
    try{
      final response = await http.get(
        Uri.parse("$domain/suppliers/all"),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final suppliers = responseBody;
        return suppliers as List<dynamic>;
      } else {
        throw Exception("An error occurred with code: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("$e");
    }
  }

}
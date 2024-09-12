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
  Future<List<dynamic>> getCustomers() async{
    try{
      final response = await http.get(
        Uri.parse("$domain/customer/all"),
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
  Future<String> deleteSupplier(id) async{
    try{
      final response =
          await http.delete(Uri.parse("${Variables().domain}/suppliers/$id"));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        return responseBody["message"];
      } else {
        return "An error occured while deleting the supplier";
      }
    }catch(error){
      throw Exception("$error");
    }
  }
  Future<List<dynamic>> getUsers() async{
    try{final response = await http.get(
      Uri.parse("${Variables().domain}/users/all"),
    );
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      return responseBody as List<dynamic>;
    }
    else{
      throw Exception(response!=null?response.statusCode: "An error occured");
    }}catch(error){
      throw Exception(error as String);
    }
  }

}
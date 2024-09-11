import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/variables.dart';

class LoginApis {
  final storage = const FlutterSecureStorage();
  bool status = false;
  final domain ="http://192.168.254.127:8080";

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    var token = await getToken();
    print(token);
    return await validateToken(token);
  }

  // Validate the token
  Future<bool> validateToken(String? token) async {
    if (token == null) {
      return false;
    }

    try {
      final url = "${Variables().domain}/users/checktoken";
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: token,
      );
      if (response.statusCode == 200){
        return true;
      } else {

        return false;
      }
    } catch(error) {
      print(error);
      return false;
    }
  }

  // Get token from secure storage
  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  // Handle login process
  Future<String> Login(Map<String, String> credentials) async {

    try {
      final url = '$domain/users/login';


      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': credentials["username"],
          'password': credentials["password"],
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody["message"] == "Successful") {
          var token = responseBody["token"];
          await storage.write(key: "token", value: token);
          return "success";
        } else {
          return "${responseBody["message"]}";
        }
      } else {
        return "Unable to login: status code : ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
  
}

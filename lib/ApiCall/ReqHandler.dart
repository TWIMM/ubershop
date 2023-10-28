import 'dart:convert';
import 'package:uber/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestService {
  static final String baseUrl =
      ApiEndpoints.baseUrl; // Replace with your API base URL

  static Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else if (response.statusCode == 500) {
      final reqRes = jsonDecode(response.body);
      return reqRes['success'];
      //throw Exception('Failed to perform POST request');
    }
  }
}

class AuthService {
  Future login(String email, String password) async {
    final loginData = {
      'login': email,
      'password': password,
    };

    final response = await RequestService.post(ApiEndpoints.login, loginData);
    final reqRes = response;
    return reqRes;
  }

  Future register(String email, String password) async {
    final registerData = {
      'login': email,
      'password': password,
    };

    final response =
        await RequestService.post(ApiEndpoints.register, registerData);
    final reqRes = response;
    return reqRes;
  }
}

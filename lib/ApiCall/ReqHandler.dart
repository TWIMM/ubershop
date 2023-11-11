import 'dart:convert';
import 'package:uber/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

    dynamic responseDy = jsonDecode(response.body);
    return responseDy['status'];
  }

  static Future<dynamic> postLikeGet(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    dynamic responseDy = jsonDecode(response.body);
    return responseDy;
  }

  static Future<dynamic> get(String endpoint, dynamic data) async {
    final response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    dynamic responseDy = jsonDecode(response.body);
    return responseDy;
  }
}

class AuthService {
  Future login(String email, String password) async {
    final loginData = {'email': email, 'password': password};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.login, loginData);
    final reqRes = response;
    return reqRes;
  }

  Future register(String email, String password, String name) async {
    final registerData = {
      'name': name,
      'email': email,
      'password': password,
    };

    final response =
        await RequestService.post(ApiEndpoints.register, registerData);
    return response;
  }
}

class CategorieService {
  Future getCategories() async {
    final data = {};

    final response = await RequestService.get(ApiEndpoints.getcategorie, data);
    final reqRes = response;
    // print('gett');
    return reqRes;
  }

  Future getProductByCategories(category_id) async {
    final data = {'category_id': category_id};

    final response = await RequestService.postLikeGet(
        ApiEndpoints.getproductbycategory, data);
    final reqRes = response;
    // print('gett');
    return reqRes['data'];
  }

  Future getproducts() async {
    final data = {};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.getproduct, data);
    final reqRes = response;
    // print('gett');
    return reqRes['products'];
  }

  Future addToCart(product_id, user_id) async {
    final data = {'user_id': user_id, 'product_id': product_id};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.addtocart, data);
    final reqRes = response;
    print('gett');
    return reqRes;
  }

  Future getCart(user_id) async {
    final data = {'user_id': user_id};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.getcart, data);
    final reqRes = response;
    //print('gett');
    return reqRes['cart'];
  }

  Future getProductFromId(product_id) async {
    final data = {'product_id': product_id};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.getspecificproduct, data);
    final reqRes = response;
    //print('gett');
    return reqRes;
  }

  Future getcount(category_id) async {
    final data = {'category_id': category_id};

    final response =
        await RequestService.postLikeGet(ApiEndpoints.getcount, data);
    final reqRes = response;
    //print('gett');
    return reqRes['count'];
  }
}

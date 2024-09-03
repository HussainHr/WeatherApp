import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/config/model/user_login_model.dart';

class AuthService {
  final String baseUrl;

  AuthService(this.baseUrl);

  // Future<UserLoginModel> signup(String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/signup"),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode({
  //       "email": email,
  //       "password": password,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return UserLoginModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to SignUp');
  //   }
  // }

  Future<UserLoginModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return UserLoginModel.fromJson(json.decode(response.body)); // i forget to decode type of data here
    } else {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to Login');
    }
  }

  //display user details at profile screen
  Future<UserLoginModel> getUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return UserLoginModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }
}

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepository{
  static String mainUrl = "http://api.malsat.kz";
  var registerUrl = "$mainUrl/api/auth/signup/";
  var loginUrl = "$mainUrl/api/token/";
  var changePasswordUrl = "$mainUrl/rest-auth/password/change/";
  var logoutUrl = "$mainUrl/rest-auth/logout/";
  var currentlyLoggedUrl = "$mainUrl/rest-auth/user/";
  var deleteAccountUrl = "$mainUrl/api/users/3/";
  var getUserDetailsUrl = "$mainUrl/api/author/2/";

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await secureStorage.read(key: 'token');
    if (value != null)
      return true;
    else
      return false;
  }

  Future<void> writeToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    secureStorage.delete(key: 'token');
    secureStorage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(Uri.parse(loginUrl), body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      print(json.decode(response.body)['access']);
      return json.decode(response.body)['access'];
    } else {
      return throw Exception("Error code: ${response.statusCode}");
    }
  }
}
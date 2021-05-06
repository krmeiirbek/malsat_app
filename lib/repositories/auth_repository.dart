import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';

class AuthRepository {
  static String mainUrl = "http://api.malsat.kz";
  var registerUrl = "$mainUrl/api/auth/signup/";
  var loginUrl = "$mainUrl/api/token/";
  var changePasswordUrl = "$mainUrl/rest-auth/password/change/";
  var logoutUrl = "$mainUrl/rest-auth/logout/";
  var currentlyLoggedUrl = "$mainUrl/rest-auth/user/";
  var deleteAccountUrl = "$mainUrl/api/users/3/";
  var getUserDetailsUrl = "$mainUrl/api/author/2/";

  Future<bool> hasToken() async {
    var value = ACCESS_TOKEN;
    if (value != null)
      return true;
    else
      return false;
  }

  Future<void> writeToken(String accessToken, String refreshToken) async {
    ACCESS_TOKEN = accessToken;
    REFRESH_TOKEN = refreshToken;
  }

  Future<void> deleteToken() async {
    print("deleted tokens");
    ACCESS_TOKEN = null;
    REFRESH_TOKEN = null;
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        // Uri.http(mainUrl, loginUrl),
        Uri.parse(loginUrl),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)['access'];
      } else {
        return throw Exception("Error code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<String> register(String email, String firstName, String phone,
      String password, String password2) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      body: {
        "email": email,
        "first_name": firstName,
        "phone": phone,
        "password": password,
        "password2": password2,
      },
    );

    print(response);

    if (response.statusCode == 201) {
      final token = await login(email, password);
      return token;
    } else {
      print(throw Exception("Error code: ${response.statusCode}"));
      return throw Exception("Error code: ${response.statusCode}");
    }
  }
}

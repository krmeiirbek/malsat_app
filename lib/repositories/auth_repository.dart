import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/user.dart';

class AuthRepository {
  static String mainUrl = "http://api.malsat.kz";
  var registerUrl = "$mainUrl/api/auth/signup/";
  var loginUrl = "$mainUrl/api/token/";
  var changePasswordUrl = "$mainUrl/rest-auth/password/change/";
  var logoutUrl = "$mainUrl/rest-auth/logout/";
  var currentlyLoggedUrl = "$mainUrl/rest-auth/user/";
  var deleteAccountUrl = "$mainUrl/api/users/3/";
  var getUserDetailsUrl = "$mainUrl/api/author/";

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
    ACCESS_TOKEN = null;
    REFRESH_TOKEN = null;
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
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
    if (response.statusCode == 201) {
      final token = await login(email, password);
      return token;
    } else {
      return throw Exception("Error code: ${response.statusCode}");
    }
  }

  Future<String> changePassword(
      String oldPassword, String newPassword, String newPassword2) async {
    final response = await http.post(
      Uri.parse(changePasswordUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
      body: {
        "new_password1": newPassword,
        "new_password2": newPassword2,
        "old_password": oldPassword,
      },
    );
    if (response.statusCode == 200) {
      return "New password has been saved.";
    } else if (response.statusCode == 400) {
      return "Invalid current password";
    } else {
      return throw Exception("Error code: ${response.statusCode}");
    }
  }

  Future<int> currentlyUser() async {
    final response = await http.get(
      Uri.parse(currentlyLoggedUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['pk'];
    } else {
      return throw Exception("Error code: ${response.statusCode}");
    }
  }

  Future<User> getUserDetails() async{
    int id = await currentlyUser();
    final response = await http.get(Uri.parse(getUserDetailsUrl + '$id'));
    if(response.statusCode == 200){
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else{
      return null;
    }
  }
}

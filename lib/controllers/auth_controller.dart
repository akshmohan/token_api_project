import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_api_project/api/api.dart';

import 'package:token_api_project/models/user_model.dart';

class AuthController extends ChangeNotifier {
  final client = http.Client();

  Future<UserModel?> login(String username, String password) async {
    final Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    try {
      final response = await client.post(
        Uri.parse("${API().baseUrl}${API().authUrl}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final UserModel user = UserModel.fromJson(result);

        SharedPreferences _pref = await SharedPreferences.getInstance();

        _pref.setString('id', user.id.toString());

        return user;
      } else {
        print("Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print("$e");
    }
  }
}

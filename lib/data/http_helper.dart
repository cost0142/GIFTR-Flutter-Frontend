import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelper {
  final String domain = '';
  String? uid = null;
  String? token = null;

  //header
  Map<String, String> headers = {
    'x-api-key': 'JiaqianHygor',
    'Content-type': 'application/json, charset=UTF-8',
  };

  var preferences;

  //get token
  void intHeaders() async {
    preferences = preferences ?? await SharedPreferences.getInstance();
    token = preferences.getString('token');
    headers.update('Authorization', (value) => 'Bearer $token');
  }

  //update token
  void updateToken() async {
    preferences = preferences ?? await SharedPreferences.getInstance();
    await preferences.setString('token', token);
    headers.update('Authorization', (value) => 'Bearer $token');
  }

  //login
  Future<String> Login(String email, String password) async {
    String endpoint = 'auth/tokens';
    Uri uri = Uri.http(domain, endpoint);

    //body Req.
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    // POST Req.
    http.Response response = await http.post(uri, body: body);
    Map<String, dynamic> resp = jsonDecode(response.body);
    if (resp['data'] != null) {
      String _token = resp['data']['token'];
      updateToken(_token);
      return _token;
    } else {
      String msg = '${resp['errors'][0]['code']} ${resp['errors'][0]['title']}';
      throw Exception(msg);
    }
  }
}

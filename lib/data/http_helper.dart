import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class HttpHelper {
  final String domain = 'http://localhost:3030';
  String? uid = null;
  String? token = null;

  Map<String, String> headers = {
    'x-api-key': 'JiaqianHygor',
    'Content-type': 'application/json, charset=UTF-8',
  };

  var prefs;

  void intHeaders() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    token = prefs.getString('token');
    headers.update('Authorization', (value) => 'Bearer $token');
  }

  void updatetoken() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    headers.update('Authorization', (value) => 'Bearer $token');
  }
}

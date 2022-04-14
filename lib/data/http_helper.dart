import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class HttpHelper {
  final String domain = 'http://localhost:3030';
  String? uid = null;
  String? token = null;

  Map<String, String> headers = {
    'Content-type': 'application/json, charset=UTF-8',
    'Accept': 'application/json',
  };
}

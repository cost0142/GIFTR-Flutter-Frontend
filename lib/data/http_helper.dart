import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async'; //for Future
import 'package:http/http.dart' as http; //our fetch call here
import 'package:shared_preferences/shared_preferences.dart';
import './user.dart';

//HttpHelper class
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
  void updateToken(token) async {
    preferences = preferences ?? await SharedPreferences.getInstance();
    await preferences.setString('token', token);
    headers.update('Authorization', (value) => 'Bearer $token');
  }

  //login
  Future<String> Login(String email, String password) async {
    String endpoint = 'auth/tokens';
    Uri uri = Uri.http(domain, endpoint);

    //body Request
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    // POST Request
    http.Response response = await http.post(uri, body: body);
    Map<String, dynamic> resp = jsonDecode(response.body);
    if (resp['data'] != null) {
      String token = resp['data']['token'];
      updateToken(token);
      return token;
    } else {
      String msg = '${resp['errors'][0]['code']} ${resp['errors'][0]['title']}';
      throw Exception(msg);
    }
  }

  //register user
  Future<User> signUp(
      String firstName, String lastName, String email, String password) async {
    String endpoint = 'auth/users';
    Uri uri = Uri.https(domain, endpoint);
    Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    // print(headers);
    // print(body);

    http.Response response = await http.post(uri, body: body);
    Map<String, dynamic> resp = jsonDecode(response.body);

    // print(resp);

    // return User(
    //   firstName: firstName,
    //   lastName: lastName,
    //   email: email,
    //   password: password,
    // )

    if (resp['data'] != null) {
      User user = User.fromJSON(resp['data']);
      // uid = user.id;
      return user;
    } else {
      String msg = '${resp['errors'][0]['code']} ${resp['errors'][0]['title']}';
      throw Exception(msg);
    }
  }

//  --------------------------------------------------------------------------------
// function formatResponseData(payload, type = 'users') {
//     if (payload instanceof Array) {
//         return {data: payload.map(resource => format(resource))}
//     } else {
//         return {data: format(payload)}
//     }
//     function format(resource) {
//         const {_id, ...attributes} = resource.toJSON ? resource.toJSON() : resource;
//         return {type, id: _id, attributes};
//     }
// }

// dynamic formatRequest(Map<String,
// dynamic> apiData, String type) {
//     Map<String, dynamic> objToSend = {
//       "data": {
//         "type": type,
//         "attributes": apiData
//       }
//     };
//     // print(jsonEncode(objToSend));
//     return jsonEncode(objToSend);
//   }
//  -----------------------------------------------------------------------------

}

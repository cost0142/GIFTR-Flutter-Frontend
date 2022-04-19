import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async'; //for Future
import 'package:http/http.dart' as http; //our fetch call here
import 'package:shared_preferences/shared_preferences.dart';
import './user.dart';
import './gift.dart';
import './person.dart';

//HttpHelper class
class HttpHelper {
  final String domain = 'localhost:3030';
  String? uid = null;
  String? token = null;

  //headers to send to the server
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'x-api-key': 'JiaqianHygor',
    'Authorization': '',
  };

  HttpHelper({this.uid, this.token});

  Future<http.Response> makeRequest(
    String method,
    Uri uri,
    Map<String, String>? headers,
    String? body,
  ) {
    body = body ?? '';
    headers = headers ??
        {
          'Content-Type': 'application/json; charset=UTF-8',
        };
    switch (method) {
      case 'post':
        return http.post(uri, headers: headers, body: body);
        break;
      case 'put':
        return http.put(uri, headers: headers, body: jsonEncode(body));
        break;
      case 'patch':
        return http.patch(uri, headers: headers, body: body);
        break;
      case 'delete':
        return http.delete(uri, headers: headers);
        break;
      default:
        //get
        return http.get(uri, headers: headers);
    }
  }

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
    token = token;
    await preferences.setString('token', token);
    headers['Authorization'] = 'Bearer $token';
  }

  //register user
  Future<User> signUp(
      String firstName, String lastName, String email, String password) async {
    String endpoint = 'auth/users';
    Uri uri = Uri.http(domain, endpoint);

    Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    http.Response response =
        await makeRequest('post', uri, headers, formatRequest(body, "users"));

    Map<String, dynamic> resp = jsonDecode(response.body);

    return User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  //login user
  Future<String> Login(String email, String password) async {
    // preferences = preferences ?? await SharedPreferences.getInstance();
    //token
    String endpoint = 'auth/tokens';
    Uri uri = Uri.http(domain, endpoint);


    //body Request email & password
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    http.Response response =
        await makeRequest('post', uri, headers, formatRequest(body, "tokens"));

    Map<String, dynamic> resp = jsonDecode(response.body);
    preferences = preferences ?? await SharedPreferences.getInstance();

    print(resp);
    headers["Authorization"] = 'Bearer ${resp['data']['token']}';
    print(headers);
    if (resp['data'] != null) {
      String token = resp['data']['token'];
      await preferences.setString('token', token);
      updateToken(token);
      return token;
    } else {
      throw Exception('Failed to login, Invalid email or password');
    }
  }

  //get user
  Future<Map> getUsers() async {
    String endpoint = 'auth/users/me';
    Uri uri = Uri.http(domain, endpoint);

    http.Response response = await http.get(uri, headers: headers);

    Map<String, dynamic> resp = jsonDecode(response.body);
    print(resp);
    return resp;
  }

  //get people
  Future<List> getPeople() async {
    String endpoint = 'api/people';
    Uri uri = Uri.http(domain, endpoint);
    print(uri);

    print(headers);

    //get request
    preferences = preferences ?? await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    headers['Authorization'] = 'Bearer $token';

    http.Response response = await http.get(uri, headers: headers);

    Map<String, dynamic> resp = jsonDecode(response.body);

    if (resp['data'] != 'null') {
      print(resp);
      List<Person> people = resp['data'].map<Person>((element) {
        Person person = Person.fromJSON(element['attributes']);
        person.id = element['id'];
        return person;
      }).toList();
      print(people);
      return people;
    } else {
      String msg = '${resp['errors'][0]['code']} ${resp['errors'][0]['title']}';
      throw Exception(msg);
    }
  }

//edit person -- PATCH
  void editPerson(
    String id,
    String fullName,
    String birthDate,
  ) async {
    String endpoint = 'api/people/${id}';
    Uri uri = Uri.http(domain, endpoint);

    Map<String, dynamic> body = {
      'fullName': fullName,
      'birthDate': birthDate.toString(),
    };

    print('niceeeeee bodddydydydydydydydydydydy $body');
    preferences = preferences ?? await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    headers['Authorization'] = 'Bearer $token';

    print('niceeeeeeeee headers $headers');
    http.Response response =
        await makeRequest('patch', uri, headers, formatRequest(body, 'person'));
    Map<String, dynamic> resp = jsonDecode(response.body);
  print('niceeeee response $resp');
  }

// -------------------- POST/

// -------------------- DELETE PEOPLE

  dynamic formatRequest(Map<dynamic, dynamic> body, String type) {
    if (body['birthDate'] != null) {
      body['birthDate'] = body['birthDate'].toString();
    }

    Map<String, dynamic> objToSend = {
      "data": {"type": type, "attributes": body}
    };
    return jsonEncode(objToSend);
  }
}

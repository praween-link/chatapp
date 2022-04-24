import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../url.dart';

class LoginService {
  static var client = http.Client();

  static Future<Map<String, dynamic>?> login(
      {required String email, required String pass}) async {
    var h = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
    var b = jsonEncode(<String, String>{
      'email': email,
      'password': pass,
    });
    log(email);
    var response = await client.post(url, headers: h, body: b);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      if (jsonString != 'null') {
        Map<String, dynamic> userMap = jsonDecode(jsonString);
        return userMap;
      } else {
        return null;
      }
    }
    return null;
  }
}

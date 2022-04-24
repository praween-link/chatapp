import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../url.dart';

class Registration {
  static var client = http.Client();

  static Future<int> register(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String photo}) async {
    var h = <String, String>{'Content-Type': 'Application/json; charset=UTF-8'};
    ////////<String, String>{'Content-Type': 'application/json; charset=UTF-8'};
    var b = jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'photo': photo,
    });
    log('$name, $email, $phone, $password, $photo');
    //
    var response = await client.post(urlReg, headers: h, body: b);
    log(response.statusCode.toString());

    if (response.statusCode == 201) {
      var jsonString = response.body;
      log(jsonString);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatapp/service/url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateUserService {
  static final client = http.Client();

  static Future<Map<String, dynamic>?> updateUser(
      {required String email,
      required String name,
      required String phone,
      required String pass,
      required String photo}) async {
    var h = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
    var b = jsonEncode(<String, String>{
      'email': email,
      'name': name,
      'phone': phone,
      'password': pass,
      'photo': photo,
    });
    var response = await client.post(urlUpdateUser, headers: h, body: b);
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

  static Future<dynamic> updateUserP(
      {required File file, required String filename}) async {
    // var h = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

    log(file.toString());
    log(filename);
    var b = FormData({
      'image': MultipartFile(file, filename: filename),
      'filename': filename,
    });

    log('message1');
    var response = await client.post(urlProfilePhotoUpload, body: b);
    log('message2');
    log(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      // log(jsonString);
      if (jsonString != 'null') {
        return 'Uploaded!';
      } else {
        return null;
      }
    }
    return null;
  }
}

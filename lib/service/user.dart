import 'dart:developer';

import 'package:chatapp/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static var client = http.Client();

  static Future<List<User>?> fetchUsers() async {
    var url = Uri.parse('http://192.168.180.243:8000/api/chatapp/registration');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return userFromJson(jsonString);
    } else {
      return null;
    }
  }
}

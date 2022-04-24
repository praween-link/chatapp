import 'dart:developer';

import 'package:chatapp/service/login_reg/login.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   // userLogin('kenyon47@considine.com', '816088');
  // }

  Future<Map<String, dynamic>?> userLogin(String email, String pass) async {
    log('user: Login Failed!;;;;;');
    var user = await LoginService.login(email: email, pass: pass);
    if (user != null) {
      log("user: ${user.toString()}");
      return user;
    } else {
      log('user: Login Failed!');
      return null;
    }
  }
}

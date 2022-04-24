import 'dart:developer';

import 'package:chatapp/service/prifile/update_profile.dart';
import 'package:get/get.dart';

class UpadateUserController extends GetxController {

  Future<Map<String, dynamic>?> userUpdate({required email, required String name, required String phone, required String pass, required String photo}) async {
    log('user: Update Failed!;;;;;');
    var user = await UpdateUserService.updateUser(
        email: email, name: name, pass: pass, phone: phone, photo: photo);
    
    if (user != null) {
      log("user update: ${user.toString()}");
      return user;
    } else {
      log('user: Update Failed!');
      return null;
    }
  }

  
}

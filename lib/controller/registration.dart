import 'package:chatapp/model/user.dart';
import 'package:chatapp/service/login_reg/registration.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<int> userRegistration({required String name, required String email, required String phone, required String password, required String photo}) async{
    try {
      int res = await Registration.register(name: name, email: email, phone: phone, password: password, photo: photo);
      return res;
    } catch (e) {
      return 0;
    }
  }
}

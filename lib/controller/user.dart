import 'package:chatapp/model/user.dart';
import 'package:chatapp/service/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  //-------------Current Logined User-------------
  var user = User().obs;

  void updateCurrentUser( 
      {required int id,
      required String email,
      required String name,
      required String phone,
      required String pass,
      required String photo}) {
    user.value = User(
      id: id,
      email: email,
      name: name,
      phone: phone,
      password: pass,
      photo: photo,
    );
    update();
  }
  //--------------------------
  // var users = <User>[].obs;

  // @override
  // void onInit() async{
  //   super.onInit();
  //   var u = await findUser("pkumar.link@gmail.com");
  //   if(u != null){
  //     log("tt----> ${u.name}");
  //   }else{
  //     log("tt----> NULLLLLL...");
  //   }
  // }

  // void fetchUser() async {
  //   List<User>? data = await UserService.fetchUsers();
  //   // log("ttt-> ${data.toString()}");
  //   List<int> l = [];
  //   for (var u in data!) {
  //     l.add(u.id!);
  //   }
  //   ids.value = l;
  //   log(ids.toString());
  // }
  Future<User?> findUser(String email) async {
    List<User>? data = await UserService.fetchUsers();
    // log("ttt-> ${data.toString()}");
    for (var u in data!) {
      if (u.email == email) {
        return u;
      }
    }
    return null;
  }
}

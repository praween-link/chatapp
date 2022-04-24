import 'package:chatapp/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Obx(() {
        return Column(
          children: [
            Text(userController.user.toJson()['name']),
            Text(userController.user.toJson()['email']),
            Text(userController.user.toJson()['phone']),
          ],
        );
      }),
      drawer: MyDrawer(user: user),
    );
  }
}

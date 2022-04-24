import 'package:chatapp/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_update.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Map<String, dynamic> user;
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
        // backgroundColor: Colors.purple,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple.withOpacity(0.8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 38,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userController.user.toJson()['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userController.user.toJson()['email'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //     color: Colors.white,
            //     child: Column(
            //       children: [
            //         ListTile(),
            //       ],
            //     ),
            //   ),
            // ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Profile Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.account_circle_sharp),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileUpdateScreen(user: user),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.logout),
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:chatapp/controller/update_user_profile.dart';
import 'package:chatapp/controller/user.dart';
import 'package:chatapp/service/prifile/update_profile.dart';
import 'package:chatapp/service/url.dart';
import 'package:chatapp/view/widgets/decoration.dart';
import 'package:chatapp/view/widgets/submit_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final UserController userController = Get.put(UserController());
  final UpadateUserController upadateUserController =
      Get.put(UpadateUserController());
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String pass = '';
  String photo = '';

  @override
  void initState() {
    super.initState();
    initCall();
  }

  void initCall() {
    setState(() {
      name = widget.user['name'] ?? '';
      email = widget.user['email'] ?? '';
      phone = widget.user['phone'] ?? '';
      pass = widget.user['password'] ?? '';
      photo = widget.user['photo'] ?? '';
    });
  }

  //
File ? pickedFile;
ImagePicker _picker = ImagePicker();

  Future pickImage(ImageSource source) async {
 var pickedImage= await _picker.pickImage(source: source);
    setState(() {
      pickedFile = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // log(_imagePath.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'My App',
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 34, 59),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              // Text(_imagePath.toString()),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'User Registration',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 34, 59),
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    //------ Profiel Photo ----
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: CircleAvatar(
                        maxRadius: 50,
                        // backgroundImage: NetworkImage('https://i.pinimg.com/474x/bc/d4/ac/bcd4ac32cc7d3f98b5e54bde37d6b09e.jpg'),
                        backgroundImage: NetworkImage(photo == 'no image'
                            ? 'https://i.pinimg.com/474x/bc/d4/ac/bcd4ac32cc7d3f98b5e54bde37d6b09e.jpg'
                            : '$path/$photo'),
                        backgroundColor: Colors.purple,
                      ), 
                    ),
                    ElevatedButton(
                        onPressed: () {
                          UpdateUserService.updateUserP(
                              file: pickedFile!, filename: 'myfilename.png');
                        },
                        child: Text('Image Upload')),
                    //-------------------------
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: MyDecoration.inputDecoration(
                          label: 'Full Name',
                          hint: 'Enter your full name',
                          icon: Icons.account_circle),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => setState(() => name = value),
                      validator: (value) {
                        if (value == '') {
                          return 'The name field should not be empty!';
                        }
                      },
                      initialValue: name,
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      decoration: MyDecoration.inputDecoration(
                          label: 'Phone Number',
                          hint: 'Enter your phone number',
                          icon: Icons.phone),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => setState(() => phone = value),
                      validator: (value) {
                        if (value == '') {
                          return 'The phone field should not be empty!';
                        }
                      },
                      initialValue: phone,
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      obscureText: true,
                      decoration: MyDecoration.inputDecoration(
                          label: 'Password',
                          hint: 'Enter your password',
                          icon: Icons.password),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) => setState(() => pass = value),
                      validator: (value) {
                        if (value == '') {
                          return 'The password field should not be empty!';
                        }
                      },
                      initialValue: pass,
                    ),
                    const SizedBox(height: 15.0),

                    //
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const HomeScreen(),
                          //   ),
                          // );
                          var res = await upadateUserController.userUpdate(
                            name: name,
                            email: email,
                            phone: phone,
                            pass: pass,
                            photo: 'no image',
                          );
                          if (res != null) {
                            // Navigator.pop(context);
                            userController.updateCurrentUser(
                                id: res['id'],
                                email: res['email'],
                                name: res['name'],
                                phone: res['phone'],
                                pass: res['password'],
                                photo: res['photo']);
                            log('user profile update successfully!');
                            // Navigator.pop(context);
                          } else {
                            log('Something is wrong!->$res');
                          }
                        }
                      },
                      child: const SubmitButton(title: 'UPDATE'),
                    ),
                    Text(
                        'n: $name, e: $email, p: $phone, ps: $pass, pt: $photo'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

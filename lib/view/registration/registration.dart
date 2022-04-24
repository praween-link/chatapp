import 'dart:developer';

import 'package:chatapp/controller/registration.dart';
import 'package:chatapp/controller/user.dart';
import 'package:chatapp/model/user.dart';
import 'package:chatapp/view/widgets/decoration.dart';
import 'package:chatapp/view/widgets/submit_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final UserController userController = Get.put(UserController());
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String pass = '';
  String photo = '';
  @override
  Widget build(BuildContext context) {
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
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      decoration: MyDecoration.inputDecoration(
                          label: 'Email Id',
                          hint: 'Enter your email id',
                          icon: Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => setState(() => email = value),
                      validator: (value) {
                        if (value == '') {
                          return 'The email field should not be empty!';
                        }
                      },
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
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
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
                    ),
                    // const SizedBox(height: 5.0),
                    // TextFormField(
                    //   decoration: MyDecoration.inputDecoration(
                    //       label: 'Profile Photo',
                    //       hint: 'Select for your profile photo',
                    //       icon: Icons.password),
                    //   keyboardType: TextInputType.visiblePassword,
                    //   onChanged: (value) => setState(() => photo = value),
                    // ),
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
                          int res =
                              await registrationController.userRegistration(
                            name: name,
                            email: email,
                            phone: phone,
                            password: pass,
                            photo: 'no image',
                          );
                          if (res==201) {
                            Navigator.pop(context);
                            log('New user add successfully!');
                            // Navigator.pop(context);
                          } else if (res==500) {
                            log('This user id alredy registerd!');
                          }else {
                            log('Not add any new user!');
                          }
                        }
                      },
                      child: const SubmitButton(title: 'NEXT'),
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

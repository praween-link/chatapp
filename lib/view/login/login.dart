import 'dart:developer';

import 'package:chatapp/controller/login.dart';
import 'package:chatapp/controller/user.dart';
import 'package:chatapp/view/home_screen.dart';
import 'package:chatapp/view/registration/registration.dart';
import 'package:chatapp/view/widgets/decoration.dart';
import 'package:chatapp/view/widgets/submit_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final UserController userController = Get.put(UserController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailEditingController = TextEditingController();

  final TextEditingController passEditingController = TextEditingController();

  bool idAndPass = true;
  bool selected = false;
  bool clicked = false;

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
                      'User Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 34, 59),
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: MyDecoration.inputDecoration(
                          label: 'Email Id',
                          hint: 'Enter your email id',
                          icon: Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                      // onChanged: (value) => setState(() => email = value),
                      controller: emailEditingController,
                      validator: (value) {
                        if (value == '') {
                          return 'The email field should not be empty!';
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
                      // onChanged: (value) => setState(() => pass = value),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,

                      controller: passEditingController,
                      validator: (value) {
                        if (value == '') {
                          return 'The password field should not be empty!';
                        }
                      },
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        idAndPass
                            ? const SizedBox()
                            : const Text(
                                'Username and Password are wrong!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    //
                    StatefulBuilder(builder: (context, StateSetter setState) {
                      return GestureDetector(
                        onTap: () async {
                          // setState(() => idAndPass = true);
                          if (_formKey.currentState!.validate()) {
                            log('contextuser.toString()');
                            var user = await loginController.userLogin(
                                emailEditingController.text,
                                passEditingController.text);
                            // log("tttt==> ${t.toString()}");
                            // log(user.toString());
                            if (user != null) {
                              log('User logined!');
                              emailEditingController.clear();
                              passEditingController.clear();
                              userController.updateCurrentUser(
                                  id: user['id'],
                                  email: user['email'],
                                  name: user['name'],
                                  phone: user['phone'],
                                  pass: user['password'],
                                  photo: user['photo']);
                              log(userController.user.toJson().toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(user: user),
                                ),
                              );
                            } else {
                              // setState(() => idAndPass = false);
                              // await Future.delayed(
                              //     const Duration(milliseconds: 2000));
                              log('User login fained!');
                            }
                          }
                        },
                        child: const SubmitButton(title: 'NEXT'),
                      );
                    }),
                    // Text('Email: $email and Pass: $pass'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("If you haven't account, "),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              //
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: Center(
                  child: AnimatedContainer(
                    width: selected ? 200.0 : 100.0,
                    height: selected ? 100.0 : 200.0,
                    color: selected ? Colors.red : Colors.blue,
                    alignment: selected
                        ? Alignment.center
                        : AlignmentDirectional.topCenter,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: const FlutterLogo(size: 75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

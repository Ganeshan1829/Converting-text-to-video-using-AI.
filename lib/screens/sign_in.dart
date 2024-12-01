// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unnecessary_null_comparison, unused_import, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, use_build_context_synchronously, use_super_parameters

// AppSignInScreen.dart
import 'package:flutter/material.dart';
import 'package:login_signup/authmanagement/authmanage.dart';
import 'package:login_signup/screens/forgot_password.dart';
import 'package:login_signup/screens/sign_up.dart';

class AppSignInScreen extends StatefulWidget {
  const AppSignInScreen({super.key});

  @override
  State<AppSignInScreen> createState() => _AppSignInScreenState();
}

class _AppSignInScreenState extends State<AppSignInScreen> {
  bool textVisible = true;
  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController userpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _signInFormKey,
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: 300,
                width: 500,
                child: Image.asset("assets/png_images/sign-in-img.png"),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: username,
                  validator: (username) {
                    if (username!.isEmpty && username != null) {
                      return "Enter the Username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter email address",
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: userpass,
                  validator: (userpass) {
                    if (userpass!.isEmpty && userpass != null) {
                      return "Enter the Password";
                    }
                    return null;
                  },
                  obscureText: textVisible,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          textVisible = !textVisible;
                        });
                      },
                      icon: textVisible
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.blue,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_signInFormKey.currentState!.validate()) {
                      String? error = await AuthManage().login(
                        username.text,
                        userpass.text,
                      );
                      if (error != null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("Error"),
                              content: Text(error),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Forgot Password ?"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppForgotPassword(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppSignUpScreen(),
                        ),
                      );
                    },
                    child: Text("Signup Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_import, use_build_context_synchronously

// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable
import 'package:flutter/material.dart';
import 'package:login_signup/authmanagement/authmanage.dart';
import 'package:login_signup/screens/sign_in.dart';

class AppSignUpScreen extends StatefulWidget {
  const AppSignUpScreen({super.key});

  @override
  State<AppSignUpScreen> createState() => _AppSignUpScreenState();
}

class _AppSignUpScreenState extends State<AppSignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController userMobile = TextEditingController();
  TextEditingController userpass = TextEditingController();
  TextEditingController userconfirmPass = TextEditingController();
  bool passTextVisible = true;
  bool cpassTextVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _signupFormKey,
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                width: 500,
                child: Image.asset("assets/png_images/sign_up_img.png"),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  controller: username,
                  validator: (username) {
                    if (username != null && username.isEmpty) {
                      return "Enter your email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Username",
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: userMobile,
                  validator: (mobileno) {
                    if (mobileno != null && mobileno.isEmpty) {
                      return "Enter your 10 digit Mobile Number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your Mobile Number",
                    labelText: "Mobile Number",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.phone,
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  obscureText: passTextVisible,
                  maxLength: 6,
                  controller: userpass,
                  validator: (userpass) {
                    if (userpass != null && userpass.isEmpty) {
                      return "Enter your 6 digit password";
                    }
                    return null;
                  },
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
                          passTextVisible = !passTextVisible;
                        });
                      },
                      icon: passTextVisible
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  obscureText: cpassTextVisible,
                  maxLength: 6,
                  controller: userconfirmPass,
                  validator: (userconfirmPass) {
                    if (userconfirmPass != null && userconfirmPass.isEmpty) {
                      return "Enter your confirm 6 digit password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your Confirm password",
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          cpassTextVisible = !cpassTextVisible;
                        });
                      },
                      icon: cpassTextVisible
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
                padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_signupFormKey.currentState!.validate()) {
                      String? error = await AuthManage()
                          .signup(username.text.trim(), userpass.text);
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already having account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppSignInScreen()),
                      );
                    },
                    child: Text("SignIn"),
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

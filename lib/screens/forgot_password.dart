// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class AppForgotPassword extends StatefulWidget {
  const AppForgotPassword({super.key});

  @override
  State<AppForgotPassword> createState() => _AppForgotPasswordState();
}

class _AppForgotPasswordState extends State<AppForgotPassword> {
  TextEditingController resetpassword = TextEditingController();
  final _resetpasskey = GlobalKey<FormState>(); // Define the form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _resetpasskey,
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 300,
                width: 500,
                child: Image.asset("assets/png_images/forgot_password_img.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Receive an email to forgot password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 10),
                child: TextFormField(
                  controller: resetpassword,
                  validator: (resetpass) {
                    if (resetpass != null && resetpass.isEmpty) {
                      return "Enter your email";
                    }
                    return null; // Return null if validation succeeds
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
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, left: 20, right: 20, top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form
                    if (_resetpasskey.currentState!.validate()) {
                      // If validation succeeds, you can perform your action here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 18.0),
                    ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/controller/registerController.dart';
import 'package:e_commers_app/module/auth/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Fill your information below or register with your social account',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GetBuilder<RegisterController>(
                builder: (logic) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: logic.profileImg == null
                            ? NetworkImage(kNOImgUrl)
                            : FileImage(logic.profileImg!) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            logic.pickImage();
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),

              // Name
              TextFormField(
                controller: controller.namecontroller,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Email
              TextFormField(
                controller: controller.emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@gmail.com')) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),

              // Password
              TextFormField(
                controller: controller.passwordcontroller,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != controller.passwordcontroller.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Profile Image Picker

              SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = controller.namecontroller.text;
                    final email = controller.emailcontroller.text;
                    final password = controller.passwordcontroller.text;
                    controller.register(
                        name: name, email: email, password: password);
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),

              SizedBox(height: 20),
              Text('or sign in with'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.apple), onPressed: () {}),
                  IconButton(icon: Icon(Icons.g_mobiledata), onPressed: () {}),
                  IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
                ],
              ),
              SizedBox(height: 20),

              // Redirect to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Text('Login', style: TextStyle(color: Colors.blue)),
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

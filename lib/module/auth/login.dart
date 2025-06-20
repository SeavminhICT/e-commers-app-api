import 'package:e_commers_app/controller/loginController.dart';
import 'package:e_commers_app/module/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final LoginController controller = Get.put(LoginController());

  bool _obscureText = true;
  @override
  void initState() {
    super.initState();

    // Wait for the widget to build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final result = ModalRoute.of(context)?.settings.arguments;
      if (result != null && result is Map<String, dynamic>) {
        controller.emailcontroller.text = result['email'] ?? '';
        controller.passwordcontroller.text = result['password'] ?? '';
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text("Sign In",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Hi! Welcome back, you've been missed"),
                  SizedBox(height: 32),

                  Text("Email or Phone Number"),
                  TextFormField(
                    controller: controller.emailcontroller,
                    decoration: InputDecoration(
                      hintText: "Enter Email or Phone Number",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  Text("Password"),
                  TextFormField(
                    controller: controller.passwordcontroller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.deepPurple)),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Fixed height button
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final email = controller.emailcontroller.text;
                                  final password =
                                      controller.passwordcontroller.text;
                                  controller.login(
                                      email: email, password: password);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  }),

                  SizedBox(height: 10),
                  Center(child: Text("Or sign in with")),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.apple), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.g_mobiledata), onPressed: () {}),
                      IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
                    ],
                  ),

                  SizedBox(height: 30), // Spacer alternative

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: TextStyle(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text("Sign Up",
                              style: TextStyle(color: Colors.deepPurple)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/models/user_model.dart';
import 'package:bookpad/services/auth_services/auth_services.dart';
import 'package:bookpad/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService authService = AuthService();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  String? errorMessage;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<String?> _signUp() {
    UserModel userModel = UserModel(username: usernameController.text.trim(), email: emailController.text.trim());
    String password = passwordController.text.trim();
    return authService.signupWithEmail(userModel, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: AppColors.mossGreen,
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("To get started!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            suffixIcon: IconButton(onPressed: _togglePassword, icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, size: 18))
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(errorMessage ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        String? result = await _signUp();
                        if (result == null) {
                          Navigator.pushNamedAndRemoveUntil(context, '/bottomBar', (route) => false);
                        } else {
                          setState(() {
                            errorMessage = result;
                          });
                        }
                      },
                      child: Text("Create Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Already have an account?",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          }, child: Text("Login",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

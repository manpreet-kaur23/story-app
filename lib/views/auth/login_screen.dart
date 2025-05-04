import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/services/auth_services/auth_services.dart';
import 'package:bookpad/views/auth/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  String? errorMessage;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<String?> _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    return authService.signInWithEmail(email, password);
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
                        Text("LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("To proceed!",
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: IconButton(onPressed: _togglePassword, icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, size: 18))
                        ),
                      ),
                    ),
                    Text(errorMessage ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: (){},
                        child: Text("Forgot password?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        String? result = await _login();
                        if (result == null) {
                          Navigator.pushNamedAndRemoveUntil(context, '/bottomBar', (route) => false);
                        } else {
                          setState(() {
                            errorMessage = result;
                          });
                        }
                      },
                      child: Text("Login",
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
                          Text("Don't have an account?",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                          }, child: Text("Sign up",
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

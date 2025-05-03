import 'package:bookpad/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.red[600],
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
                    color: Colors.white,
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){},
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

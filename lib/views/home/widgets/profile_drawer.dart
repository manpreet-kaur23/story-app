import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/services/auth_services/auth_services.dart';
import 'package:bookpad/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends StatelessWidget {
  ProfileDrawer({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 320,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.lime, AppColors.mossGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.close),
                      )
                    ],
                  ),
                  CircleAvatar(radius: 60),
                  SizedBox(height: 10),
                  Text("Manpreet Kaur"),
                  SizedBox(height: 5),
                  Text("@mani2222"),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit your profile"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Private Information"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text("Settings"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text("Logout",
              style: TextStyle(
                  color: Colors.red
              ),
            ),
            onTap: (){
              authService.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            },
          )
        ],
      ),
    );
  }
}

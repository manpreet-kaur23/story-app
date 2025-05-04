import 'package:bookpad/constants/app_theme.dart';
import 'package:bookpad/widgets/bottom_bar.dart';
import 'views/home/home_screen.dart';
import 'views/splash/splash_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/signup_screen.dart';
import 'views/home/search_screen.dart';
import 'views/home/bookmark_screen.dart';
import 'views/home/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mossGreen),
      // ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/bottomBar': (context) => BottomBar(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/bookmark': (context) => BookmarkScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

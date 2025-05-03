import 'package:bookpad/constants/custom_colors.dart';
import 'package:bookpad/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
    });
    return Scaffold(
      backgroundColor: AppColors.mossGreen,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BookPad",
              // style: Theme.of(context).textTheme.titleLarge
              style: TextStyle(
                fontSize: 20,
                color: AppColors.cream,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

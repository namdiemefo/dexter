import 'package:dexter_todo/helpers/assets/colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bPurple,
      body: Container(
        child: Center(
          // child: SvgPicture.asset(AppImages.logo),
        ),
      ),
    );
  }
}
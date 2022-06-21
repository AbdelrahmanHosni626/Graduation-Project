import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fuel_station/shared/cubit/cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  final Widget widget;

  const SplashScreen({Key? key, required this.widget}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/fuel.json'),
      nextScreen: widget.widget,
      splashIconSize: 500,
      animationDuration: Duration(milliseconds: 1600),
      backgroundColor: Colors.white,
    );
  }
}

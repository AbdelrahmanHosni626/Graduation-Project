import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_station_driver/modules/login/login_screen.dart';
import 'package:fuel_station_driver/modules/register/register_screen.dart';
import 'package:fuel_station_driver/shared/components/componets.dart';
import 'package:fuel_station_driver/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class HomeLogin extends StatelessWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/fuel.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'G&E \n PORTABLE STATIONS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultButton(function: (){
                    navigateTo(context, LoginScreen());
                  }, text: 'sign in',isUpperCase: true),
                  SizedBox(height: 1.h,),
                  // defaultTextButton(function: (){
                  //   navigateTo(context, RegisterScreen());
                  // }, text: 'sign up',color: Colors.white),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_station_driver/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: color,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
  primarySwatch: color,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: secondColor,
    unselectedItemColor: Colors.white,
    elevation: 20.0,
    selectedIconTheme: IconThemeData(size: 3.5.h),
    unselectedIconTheme:  IconThemeData(size: 2.5.h),
    selectedLabelStyle: TextStyle(fontSize: 9.sp),
    unselectedLabelStyle: TextStyle(fontSize: 8.sp),
    backgroundColor: defaultColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 8.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.5,
    ),
    subtitle2: TextStyle(
      fontSize: 8.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.5,
    ),
    caption: TextStyle(
      fontSize: 8.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      height: 1.5,
    ),
  ),
  fontFamily: 'Jannah',
);
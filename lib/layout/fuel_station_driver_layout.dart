import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_station_driver/layout/cubit/cubit.dart';
import 'package:fuel_station_driver/layout/cubit/states.dart';
import 'package:fuel_station_driver/modules/home_login/home_login.dart';
import 'package:fuel_station_driver/modules/order/order_screen.dart';
import 'package:fuel_station_driver/shared/components/componets.dart';
import 'package:fuel_station_driver/shared/components/constants.dart';
import 'package:fuel_station_driver/shared/network/local/cache_helper.dart';
import 'package:fuel_station_driver/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class FuelStationDriverLayout extends StatefulWidget {
  @override
  State<FuelStationDriverLayout> createState() =>
      _FuelStationDriverLayoutState();
}

class _FuelStationDriverLayoutState extends State<FuelStationDriverLayout> {
  bool go = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FuelStationCubit, FuelStationStates>(
      listener: (context, state) {
        var cubit = FuelStationCubit.get(context);
        if (state is GetOrderSuccessState) {
          Timer.periodic(new Duration(seconds: 25), (timer) async {
            if (cubit.order!.data == null) {
              cubit.getOrder();
            }
          });
          if (cubit.order!.data != null) {
            navigateTo(
                context,
                OrderScreen(
                  price: '${cubit.order!.data!.price}',
                  name: '${cubit.order!.data!.user!.name}',
                  phone: '${cubit.order!.data!.user!.phone}',
                  car_num: '${cubit.order!.data!.carNum}',
                ));
          }
        }
      },
      builder: (context, state) {
        var cubit = FuelStationCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/map-default.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: const Color(0xFF32384D).withOpacity(0.5)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.h),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                      onPressed: () {
                        token = null;
                        CacheHelper.removeData(key: 'token');
                        navigateAndFinish(context, HomeLogin());
                      },
                      icon: Icon(Icons.logout)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          go = true;
                        });
                        cubit.getOrder();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 72.0,
                        height: 72.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: defaultColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: 64.0,
                          height: 64.0,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'GO',
                                  style: TextStyle(
                                    fontSize: 15.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                width: 64.0,
                                height: 64.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 162.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                    color: Colors.white,
                  ),
                  child: go == false
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'You\'re offiline',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: const Color(0xFF282F39),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            myDivider(),
                            SizedBox(
                              height: 10,
                            ),
                            SvgPicture.asset(
                              'assets/images/Path_2087.svg',
                              color: Colors.green,
                              width: 23,
                              height: 23,
                            ),
                            Text(
                              '4.75',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: const Color(0xFF282F39),
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rating',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF7F7F7F),
                                height: 1.13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Finding orders',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: const Color(0xFF282F39),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            LinearProgressIndicator(),
                            Expanded(
                              child: Container(
                                color: const Color(0xFFF2F5F7),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Opportunity nearby',
                                        style: TextStyle(
                                          fontSize: 14.0.sp,
                                          color: const Color(0xFF3DB24B),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

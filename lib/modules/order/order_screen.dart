import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fuel_station_driver/layout/cubit/cubit.dart';
import 'package:fuel_station_driver/layout/fuel_station_driver_layout.dart';
import 'package:fuel_station_driver/shared/components/componets.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  String price;
  String name;
  String phone;
  String car_num;

  OrderScreen({
    Key? key,
    required this.price,
    required this.name,
    required this.phone,
    required this.car_num,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool show1 = false;
  bool show2 = true;

  @override
  Widget build(BuildContext context) {
    var cubit = FuelStationCubit.get(context);
    return Scaffold(
      appBar: defaultAppBar(context: context, title: ''),
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
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 6.5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                '£',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF3DB24B),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              widget.price,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xFF282F39),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myDivider(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.sp,
                          color: const Color(0xFF282F39),
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        widget.phone,
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF282F39),
                          height: 1.5,
                        ),
                      ),
                      Text(
                        widget.car_num,
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.sp,
                          color: const Color(0xFF282F39),
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Visibility(
                        visible: show2,
                        child: InkWell(
                          onTap: () {
                            cubit.openMap('${cubit.order!.data!.latituide}',
                                '${cubit.order!.data!.longtuide}');
                            setState(() {
                              show1 = !show1;
                              show2 = !show2;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              border: Border.all(
                                width: 1.0,
                                color: const Color(0xFF3DB24B),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  color: const Color(0xFF3DB24B),
                                  letterSpacing: 0.28,
                                  fontWeight: FontWeight.w700,
                                  height: 1.29,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: show1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  child: InkWell(
                    onTap: () {
                     navigateAndFinish(context, FuelStationDriverLayout());
                    },
                    child: SizedBox(
                      width: 279.0,
                      height: 40.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(0.01, 0.05),
                            width: 279.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              'Find Other orders',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: const Color(0xFFDF2F45),
                                letterSpacing: 0.28,
                                fontWeight: FontWeight.w700,
                                height: 1.29,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Positioned(
                            right: 9.0,
                            bottom: 3.0,
                            child: Container(
                              width: 260.0,
                              height: 33.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: const Color(0xFFDF2F45),
                                ),
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
        ],
      ),
    );
  }
}

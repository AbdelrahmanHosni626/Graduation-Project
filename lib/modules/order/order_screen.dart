import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station/layout/cubit/cubit.dart';
import 'package:fuel_station/layout/cubit/states.dart';
import 'package:fuel_station/layout/fuel_station_layout.dart';
import 'package:fuel_station/shared/components/componets.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  String price;

  OrderScreen({Key? key, required this.price}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = FuelStationCubit.get(context);
    Timer.periodic(new Duration(seconds: 25), (timer) async {
      if (cubit.order!.data!.driver == null) {
        // print('hh ${cubit.order!.data!.driver}');
        cubit.getOrder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FuelStationCubit, FuelStationStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FuelStationCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: ''),
          body: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 250,
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
                                  '${widget.price}',
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
                          cubit.order!.data!.driver != null
                              ? Column(
                                  children: [
                                    Text(
                                      '${cubit.order!.data!.driver!.name}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${cubit.order!.data!.driver!.phone}',
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 13.sp,
                                        color: const Color(0xff7f7f7f),
                                        decoration: TextDecoration.underline,
                                        height: 1.125,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'On the way to you',
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 13.sp,
                                        color: const Color(0xff7f7f7f),
                                        height: 1.125,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Lottie.asset(
                                        'assets/order2.json',
                                      ),
                                    ),
                                    Text('Please wait .......'),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        // cubit.getOrder();
                        // print('hh${cubit.order!.data!.driver}');
                        navigateAndFinish(context, FuelStationLayout());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 72.0,
                        height: 72.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
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
                              Positioned(
                                right: 10.0,
                                bottom: 22.0,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 10.0.sp,
                                    color: const Color(0xFFDF2F45),
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
                                    color: const Color(0xFFDF2F45)
                                        .withOpacity(0.2),
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
      },
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station/layout/cubit/cubit.dart';
import 'package:fuel_station/layout/cubit/states.dart';
import 'package:fuel_station/modules/home_login/home_login.dart';
import 'package:fuel_station/modules/order/order_screen.dart';
import 'package:fuel_station/shared/adaptive/adaptivw_indicator.dart';
import 'package:fuel_station/shared/components/componets.dart';
import 'package:fuel_station/shared/components/constants.dart';
import 'package:fuel_station/shared/network/local/cache_helper.dart';
import 'package:fuel_station/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';

class FuelStationLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var carNumberController = TextEditingController();
    var descriptionController = TextEditingController();
    var serviceController = TextEditingController();
    var priceController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    List<Map<String, dynamic>> items = [
      {'value': 0, 'label': 'Gasoline_92'},
      {'value': 1, 'label': 'Gasoline_95'},
      {'value': 2, 'label': 'Electric'},
    ];
    int? price = 0;
    var Value;
    return BlocConsumer<FuelStationCubit, FuelStationStates>(
      listener: (context, state) {
        if (state is StoreSuccessState) {
          FuelStationCubit.get(context).getOrder();
        }
        if (state is GetOrderSuccessState) {
          navigateTo(
              context,
              OrderScreen(
                price: '${priceController.text}',
              ));
        }
      },
      builder: (context, state) {
        var cubit = FuelStationCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Get your order',
              style: TextStyle(fontSize: 25.sp),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  token = null;
                  CacheHelper.removeData(key: 'token');
                  navigateAndFinish(context, HomeLogin());
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) return 'Service is required';
                      },
                      isExpanded: true,
                      hint: Text(
                        'Select your service',
                        style: TextStyle(
                          fontSize: 14,
                          color: kSecondaryColor,
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: kSecondaryColor),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kSecondaryColor,
                      ),
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 8, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<int>(
                                value: item['value'],
                                child: Text(
                                  item['label'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        Value = value;
                        if (value == 0) {
                          price = 10;
                        } else if (value == 1) {
                          price = 11;
                        } else {
                          price = 3;
                        }
                        print(Value);
                        print(price);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      style: TextStyle(
                        letterSpacing: 5.0,
                      ),
                      controller: carNumberController,
                      keyboardType: TextInputType.name,
                      validate: (s) {
                        if (s!.trim().isEmpty) return 'Car Number is required';
                      },
                      onChange: (value) {
                        value = carNumberController.value.text;
                      },
                      label: 'Car Number',
                      labelStyle: TextStyle(
                        letterSpacing: 0.0,
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () async {
                          await cubit.setCurrentLocation();
                          print(
                              " longitude ${cubit.currentLocation!.longitude} latitude ${cubit.currentLocation!.latitude}");
                        },
                        text: 'Get Current Location'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xFF707070),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Latitude \n ${cubit.currentLocation != null ? cubit.currentLocation!.latitude : '0'}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Leelawadee UI',
                                fontSize: 13.0.sp,
                                color: Colors.black.withOpacity(0.44),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xFF707070),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Longitude \n ${cubit.currentLocation != null ? cubit.currentLocation!.longitude : '0'}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Leelawadee UI',
                                fontSize: 13.0.sp,
                                color: Colors.black.withOpacity(0.44),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myDivider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 35.w,
                          child: defaultFormField(
                              controller: serviceController,
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                value = serviceController.value.text;
                                if (value.isNotEmpty) {
                                  int service =
                                      int.parse(serviceController.value.text);
                                  priceController.text = '${service * price!}';
                                  // print(value.toString());
                                }
                              },
                              validate: (value) {
                                if (value!.trim().isEmpty)
                                  return 'Liters or KiloWatt is required';
                              },
                              label: 'Liters or KiloWatt'),
                        ),
                        Container(
                          width: 38.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Image_3.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: 35.w,
                          child: defaultFormField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              validate: (value) {
                                if (value!.trim().isEmpty)
                                  return 'Price is required';
                              },
                              onChange: (value) {
                                value = priceController.value.text;
                                if (value.isNotEmpty) {
                                  int Price =
                                      int.parse(priceController.value.text);
                                  serviceController.text = '${Price / price!}';
                                  // print(value);
                                }
                              },
                              label: 'Price'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        label: 'More Details (Optional)',
                        onChange: (value) {
                          value = descriptionController.value.text;
                        },
                        maxLines: 5),
                    SizedBox(
                      height: 20,
                    ),
                    (state is! StoreLoadingState)
                        ? defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                if (cubit.currentLocation != null) {
                                  cubit.storeOrder(
                                    gas_type: '${Value}',
                                    car_num: carNumberController.text,
                                    latitude:
                                        '${cubit.currentLocation!.latitude}',
                                    longitude:
                                        '${cubit.currentLocation!.longitude}',
                                    litres: serviceController.text,
                                    price: priceController.text,
                                    details: descriptionController.value.text,
                                  );
                                } else {
                                  showToast(
                                      text: 'Please get your location',
                                      state: ToastStates.WARNING);
                                }
                              }
                              // print('l is  ${serviceController.text}');
                              // print('p is  ${priceController.text}');
                              // navigateTo(context, OrderScreen(price: '5',));
                              // FuelStationCubit.get(context).getOrder();
                            },
                            text: 'Confirm')
                        : Center(
                            child: AdaptiveIndicator(
                            os: getOS(),
                          )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

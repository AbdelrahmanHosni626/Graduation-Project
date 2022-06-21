import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station_driver/layout/cubit/states.dart';
import 'package:fuel_station_driver/models/order.dart';
import 'package:fuel_station_driver/shared/network/remote/custom_dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';


class FuelStationCubit extends Cubit<FuelStationStates> {
  FuelStationCubit() : super(FuelStationInitialState());

  static FuelStationCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(FuelStationChangePasswordVisibilityState());
  }
  Position? currentLocation;

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  setCurrentLocation() async {
    currentLocation = await getCurrentLocation();
    emit(GetCurrentLocationState());
  }

  Order? order;

  void getOrder() async {
    emit(GetOrderLoadingState());
    try {
      final data = await CustomDio().send(
        reqMethod: "get",
        path: "/last-driver-order",
      );
      print(data);
      order =Order.fromJson(data.data);
      // print(order!.data!.price);
      emit(GetOrderSuccessState());
    } catch (err) {
      print(err.toString());
      emit(GetOrderErrorState(err.toString()));
    }
  }
   Future<void> openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

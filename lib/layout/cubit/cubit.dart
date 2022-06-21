import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station/layout/cubit/states.dart';
import 'package:fuel_station/models/order.dart';
import 'package:fuel_station/shared/network/remote/custom_dio.dart';
import 'package:geolocator/geolocator.dart';

class FuelStationCubit extends Cubit<FuelStationStates> {
  FuelStationCubit() : super(FuelStationInitialState());

  static FuelStationCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

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

  void storeOrder({
    required String gas_type,
    required String car_num,
    required String latitude,
    required String longitude,
    required String litres,
    required String price,
    required String details,
  }) async {
    emit(StoreLoadingState());
    try {
      final data = await CustomDio().send(
        reqMethod: "post",
        path: "/store-order",
        body: {
          'gas_type': gas_type,
          'car_num': car_num,
          'latituide': latitude,
          'longtuide': longitude,
          'litres': litres,
          'price': price,
          'details': details,
        },
      );
      print(data);
      emit(StoreSuccessState());
    } catch (err) {
      print(err.toString());
      emit(StoreErrorState(err.toString()));
    }
  }

  Order? order;

  void getOrder() async {
    emit(GetOrderLoadingState());
    try {
      final data = await CustomDio().send(
        reqMethod: "get",
        path: "/last-user-order",
      );
      print(data);
      order =Order.fromJson(data.data);
      print(order!.data!.price);
      emit(GetOrderSuccessState());
    } catch (err) {
      print(err.toString());
      emit(GetOrderErrorState(err.toString()));
    }
  }

}

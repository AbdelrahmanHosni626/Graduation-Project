import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station/shared/cubit/states.dart';
import 'package:fuel_station/shared/network/local/cache_helper.dart';
import 'package:location/location.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  Future<void> checkLocationServicesInDevice() async {
    Location location = new Location();

    var _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      var _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        // _location = await location.getLocation();

        // print(_location.latitude.toString() + " " + _location.longitude.toString());

      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      var _serviceEnabled = await location.requestService();

      if (_serviceEnabled) {
        var _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed before');
        } else {
          _permissionGranted = await location.requestPermission();

          if (_permissionGranted == PermissionStatus.granted) {
            print('user allowed');
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }
}

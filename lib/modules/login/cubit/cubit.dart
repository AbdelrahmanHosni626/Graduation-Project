import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station_driver/models/login_model.dart';
import 'package:fuel_station_driver/modules/login/cubit/states.dart';
import 'package:fuel_station_driver/shared/network/remote/custom_dio.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  LoginModel? loginModel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      final data = await CustomDio().send(
        reqMethod: "post",
        path: "/login",
        body: {
          'email': email,
          'password': password,
        },
      );
      loginModel = LoginModel.fromJson(data.data);
      print(data);
      print(loginModel!.data!.email);
      emit(LoginSuccessState(loginModel!));
    } catch (err) {
      print(err.toString());
      emit(LoginErrorState(err.toString()));
    }
    // DioHelper.postData(
    //   url: '/login',
    //   data: {
    //     'email': email,
    //     'password': password
    //   },
    // ).then((value) {
    //   // print(value.data);
    //   loginModel = LoginModel.fromJson(value.data);
    //   emit(LoginSuccessState(loginModel!));
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(LoginErrorState(error.toString()));
    // });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}

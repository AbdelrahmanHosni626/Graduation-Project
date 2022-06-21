import 'package:fuel_station/models/login_model.dart';
import 'package:fuel_station/modules/register/cubit/states.dart';
import 'package:fuel_station/shared/network/remote/custom_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async{
    emit(RegisterLoadingState());
    try {
      final data = await CustomDio().send(
        reqMethod: "post",
        path: "/register",
        body:  {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );
      loginModel = LoginModel.fromJson(data.data);
      print(data);
      print(loginModel!.data!.email);
      emit(RegisterSuccessState(loginModel!));
    } catch (err) {
      print(err.toString());
      emit(RegisterErrorState(err.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}

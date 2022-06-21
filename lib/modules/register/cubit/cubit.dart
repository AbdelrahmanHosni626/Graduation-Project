import 'dart:io';

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station_driver/models/login_model.dart';
import 'package:fuel_station_driver/modules/register/cubit/states.dart';
import 'package:fuel_station_driver/shared/network/remote/custom_dio.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String ssn,
  }) async {
    emit(RegisterLoadingState());
    try {
      final data = await CustomDio().uploadFile(
        filePath: image!.path,
        path: "/driver-register",
        body: [
          {'name': name},
          {'email': email},
          {'phone': phone},
          {'password': password},
          {'ssn': ssn},
        ],
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

  File? image;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      print(Uri.file(image!.path).pathSegments.last);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
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

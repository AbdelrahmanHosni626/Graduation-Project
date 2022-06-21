import 'package:fuel_station_driver/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class PostImagePickedSuccessState extends RegisterStates {}

class PostImagePickedErrorState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

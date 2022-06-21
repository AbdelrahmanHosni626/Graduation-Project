import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station_driver/modules/login/login_screen.dart';
import 'package:fuel_station_driver/modules/register/cubit/cubit.dart';
import 'package:fuel_station_driver/modules/register/cubit/states.dart';
import 'package:fuel_station_driver/shared/adaptive/adaptivw_indicator.dart';
import 'package:fuel_station_driver/shared/components/componets.dart';
import 'package:fuel_station_driver/shared/components/constants.dart';
import 'package:fuel_station_driver/shared/styles/colors.dart';
import 'package:fuel_station_driver/shared/styles/icon_broken.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nb_utils/src/extensions/string_extensions.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var SSNController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  var phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            // if(!state.loginModel.error!)
            showToast(
              text:
                  'Registered successfully! We sent an email to you to verify your account!',
              state: ToastStates.SUCCESS,
            );
            navigateAndFinish(
              context,
              LoginScreen(),
            );
          }
          if (state is RegisterErrorState) {
            showToast(
              text: 'Email or password is not correct!',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(context: context, title: 'Sign up'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          phone = number.phoneNumber;
                          print(phone);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          showFlags: true,
                          useEmoji: true,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: phoneController,
                        formatInput: false,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validate: (s) {
                          if (s!.trim().isEmpty) return 'Username is required';
                        },
                        label: 'Name',
                        prefix: IconBroken.Profile,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (s) {
                          if (s!.trim().isEmpty) return 'Email is required';
                          if (!s.trim().validateEmail())
                            return 'Email is not valid';
                          return null;
                        },
                        label: 'Email',
                        prefix: IconBroken.Message,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        suffix: RegisterCubit.get(context).suffix,
                        onSubmit: (value) {},
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: IconBroken.Unlock,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myDivider(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: SSNController,
                        keyboardType: TextInputType.text,
                        validate: (s) {
                          if (s!.trim().isEmpty) return 'SSN is required';
                        },
                        label: 'SSN',
                        prefix: IconBroken.Message,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            RegisterCubit.get(context).getPostImage();
                          },
                          child: Container(
                            width: 40.0.w,
                            height: 40.0,
                            color: const Color(0xFF98FF98),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.cloud_upload),
                                Text(
                                  'Upload National ID',
                                  style: TextStyle(
                                    fontFamily: 'Leelawadee UI',
                                    fontSize: 9.0.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'By continuing, I confirm that i have read & agree to the\nTerms & conditions and Privacy policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      (state is! RegisterLoadingState)
                          ? defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  if (RegisterCubit.get(context).image != null) {
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phone,
                                      ssn: SSNController.text,
                                    );
                                  }else {
                                    showToast(
                                        text: 'Please Upload National ID',
                                        state: ToastStates.WARNING);
                                  }
                                }
                              },
                              text: 'CONTINUE',
                              isUpperCase: true,
                            )
                          : Center(
                              child: AdaptiveIndicator(
                              os: getOS(),
                            )),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

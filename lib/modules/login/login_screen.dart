import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station_driver/layout/fuel_station_driver_layout.dart';
import 'package:fuel_station_driver/modules/login/cubit/cubit.dart';
import 'package:fuel_station_driver/modules/login/cubit/states.dart';
import 'package:fuel_station_driver/shared/adaptive/adaptivw_indicator.dart';
import 'package:fuel_station_driver/shared/components/componets.dart';
import 'package:fuel_station_driver/shared/components/constants.dart';
import 'package:fuel_station_driver/shared/network/local/cache_helper.dart';
import 'package:fuel_station_driver/shared/styles/icon_broken.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(
              text: 'Login Success',
              state: ToastStates.SUCCESS,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.token,
            ).then((value) {
              token = state.loginModel.token;
            });
            navigateAndFinish(
              context,
              FuelStationDriverLayout(),
            );
          } else if (state is LoginErrorState){
            showToast(
              text: 'Email or password is not correct!',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(context: context, title: ''),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: IconBroken.Message,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passController.text,
                              );
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: IconBroken.Unlock,
                          suffix: LoginCubit.get(context).suffix,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (state is! LoginLoadingState)
                            ? defaultButton(
                                function: () {
                                  // navigateAndFinish(
                                  //   context,
                                  //   FuelStationLayout(),
                                  // );
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                  }
                                },
                                text: 'Sign in')
                            : Center(
                                child: AdaptiveIndicator(
                                os: getOS(),
                              )),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'Don\'t have an account?',
                        //       style: Theme.of(context).textTheme.subtitle1,
                        //     ),
                        //     defaultTextButton(
                        //         function: () {
                        //           navigateTo(context, RegisterScreen());
                        //         },
                        //         text: 'register'),
                        //   ],
                        // ),
                      ],
                    ),
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

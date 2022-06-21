import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_station/layout/cubit/cubit.dart';
import 'package:fuel_station/layout/fuel_station_layout.dart';
import 'package:fuel_station/modules/home_login/home_login.dart';
import 'package:fuel_station/modules/splash_screen/splash_screen.dart';
import 'package:fuel_station/shared/bloc_observer.dart';
import 'package:fuel_station/shared/components/constants.dart';
import 'package:fuel_station/shared/cubit/cubit.dart';
import 'package:fuel_station/shared/cubit/states.dart';
import 'package:fuel_station/shared/network/local/cache_helper.dart';
import 'package:fuel_station/shared/network/remote/custom_dio.dart';
import 'package:fuel_station/shared/network/remote/custom_dio_options.dart';
import 'package:fuel_station/shared/network/remote/dio_helper.dart';
import 'package:fuel_station/shared/styles/themes.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  CustomDio.setInitData(
    CustomDioOptions(
      baseUrl: "https://gas.qhorse.online/api",
    ),
  );
  Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget? widget;
  token = CacheHelper.getData(key: 'token');
  if (token != null)
    widget = SplashScreen(
      widget: FuelStationLayout(),
    );
  else
    widget = SplashScreen(
      widget: HomeLogin(),
    );

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => MyApp(
  //       isDark: isDark,
  //       startWidget: widget,
  //     ),
  //   ),
  // );
  runApp(
    MyApp(
      isDark: isDark,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => FuelStationCubit()),
          BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..checkLocationServicesInDevice(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  useInheritedMediaQuery: true,
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: AppCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: startWidget,
                );
              },
            );
          },
        ));
  }
}

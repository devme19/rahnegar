import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/features/auth/presentation/manager/bloc/bloc/pages/intro_page/intro_page.dart';

import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/get_brands_cubit/get_brands_cubit.dart';
import 'package:rahnegar/features/main/presentation/pages/main_page.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/blocs/map/map_bloc.dart';
import 'package:rahnegar/features/user/presentation/manager/bloc/blocs/user_bloc.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/routes/route_names.dart';
import '../features/auth/presentation/manager/bloc/bloc/blocs/otp_bloc.dart';
import '../features/auth/presentation/manager/bloc/bloc/pages/otp_page/otp_page.dart';
import '../features/auth/presentation/manager/getx/pages/login_page/login_page.dart';
import '../features/car/presentation/manager/bloc/pages/add_car/add_car_page.dart';
import '../features/intro/presentation/manager/bloc/blocs/authorize/authorize_cubit.dart';
import '../features/intro/presentation/manager/bloc/pages/splash_page/splash_page.dart';
import '../features/user/presentation/manager/bloc/pages/user_info_page/user_info_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => const IntroPage());
        //  return MaterialPageRoute(
        //     builder: (_) => MultiBlocProvider(providers: [
        //       BlocProvider.value(
        //         value: locator<CarBloc>(),
        //       ),
        //       BlocProvider.value(
        //         value: locator<MapBloc>(),
        //       ),
        //     ], child: MainPage()));
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: locator<AuthorizeCubit>(),
                  child: SplashPage(),
                ));
      case RouteNames.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.introPage:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case RouteNames.otpPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: locator<OtpBloc>(),
                  child: OtpPage(),
                ));
      case RouteNames.mainPage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: locator<CarBloc>(),
                  ),
                  BlocProvider.value(
                    value: locator<MapBloc>(),
                  ),
                ], child: MainPage()));
      case RouteNames.userInfoPage:
        bool isSetting = false;
        if(settings.arguments != null) {
          isSetting = true;
        }

        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: locator<UserBloc>(),
                  child: UserInfoPage(
                    isSetting: isSetting,
                  ),
                ));
      // case '/addCar':
      //   return MaterialPageRoute(
      //       builder: (_)=> BlocProvider.value(
      //         value: AddCarBloc(),
      //         child: AddCar(),
      //       ));
      case RouteNames.addCarPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: locator<CarBloc>(),
                  child: AddCarPage(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

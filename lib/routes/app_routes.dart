import 'package:get/get.dart';
import 'package:rahnegar/features/auth/presentation/manager/getx/pages/otp_page/otp_page.dart';
import 'package:rahnegar/features/car/presentation/manager/getx/pages/home/bindings/home_page_binding.dart';
import 'package:rahnegar/features/car/presentation/widgets/chart_widget.dart';
import 'package:rahnegar/features/main/presentation/pages/main_page.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/route_history_page/binding/route_history_page_binding.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/route_history_page/route_history_page.dart';
import 'package:rahnegar/features/user/presentation/manager/getx/pages/user_info_page/binding/user_info_page_binding.dart';
import 'package:rahnegar/routes/route_names.dart';

import '../features/auth/presentation/manager/getx/pages/login_page/login_page.dart';
import '../features/auth/presentation/manager/getx/pages/otp_page/binding/otp_page_binding.dart';
import '../features/car/presentation/manager/getx/pages/add_car/add_car_page.dart';
import '../features/car/presentation/manager/getx/pages/add_car/bindings/add_car_binding.dart';
import '../features/car/presentation/manager/getx/pages/home/home_page.dart';
import '../features/intro/presentation/manager/getx/pages/select_vehicle_page/select_vehicle_page.dart';
import '../features/intro/presentation/manager/getx/pages/splash_page/binding/splash_page_binding.dart';
import '../features/intro/presentation/manager/getx/pages/splash_page/splash_page.dart';
import '../features/map/presentation/manager/GetX/page/map_page/binding/map_page_binding.dart';
import '../features/user/presentation/manager/getx/pages/user_info_page/user_info_page.dart';






class App {
  static final pages = [
    GetPage(
        name: RouteNames.splashPage,
        transition: Transition.fadeIn,
        page: ()=> SplashPage(),
      binding: SplashPageBinding()
    ),
    GetPage(
        name: RouteNames.addCarPage,
        transition: Transition.fadeIn,
        page: () => AddCarPage(),
        binding:AddCarBinding()
    ),
    GetPage(
        name: RouteNames.loginPage,
        transition: Transition.fadeIn,
        page: ()=> const LoginPage()),
    GetPage(
        name: RouteNames.homePage,
        transition: Transition.fadeIn,
        page: ()=> HomePage()),
    GetPage(
        transition: Transition.fadeIn,
        name: RouteNames.mainPage, page: ()=> MainPage(),
      bindings: [MapPageBinding(),HomePageBinding()]
    ),
    GetPage(
      transition: Transition.fadeIn,
        name: RouteNames.otpPage, page: ()=> OtpPage(),
      binding: OtpPageBinding()
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: RouteNames.selectVehiclePage, page: ()=> const SelectVehiclePage(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: RouteNames.userInfoPage, page: ()=> UserInfoPage(),
      binding: UserInfoPageBinding()
    ),
    GetPage(
        transition: Transition.fadeIn,
        name: RouteNames.routeHistoryPage, page: ()=> RouteHistoryPage(),
        binding: RouteHistoryPageBinding()
    ),
    // GetPage(
    //     transition: Transition.fadeIn,
    //     name: RouteNames.chartPage, page: ()=> ChartWidget(),
    //
    // )
  ];
}

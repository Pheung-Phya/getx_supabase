import 'package:get/get.dart';

import '../modules/addproduct/bindings/addproduct_binding.dart';
import '../modules/addproduct/views/addproduct_view.dart';
import '../modules/detailproduct/bindings/detailproduct_binding.dart';
import '../modules/detailproduct/views/detailproduct_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/updateproduct/bindings/updateproduct_binding.dart';
import '../modules/updateproduct/views/updateproduct_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ADDPRODUCT,
      page: () => AddproductView(),
      binding: AddproductBinding(),
    ),
    GetPage(
      name: _Paths.DETAILPRODUCT,
      page: () => const DetailproductView(),
      binding: DetailproductBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPRODUCT,
      page: () => const UpdateProductView(),
      binding: UpdateproductBinding(),
    ),
  ];
}

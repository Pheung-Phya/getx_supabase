import 'package:get/get.dart';

class LoginController extends GetxController {
  final togglePassword = false.obs;

  void toggleShowPassword() {
    togglePassword.value = !togglePassword.value;
  }
}

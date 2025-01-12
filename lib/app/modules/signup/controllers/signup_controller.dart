import 'package:get/get.dart';

class SignupController extends GetxController {
  final togglePassword = false.obs;

  void toggleShowPassword() {
    togglePassword.value = !togglePassword.value;
  }
}

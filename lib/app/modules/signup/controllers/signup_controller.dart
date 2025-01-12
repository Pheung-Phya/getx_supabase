import 'package:get/get.dart';
import 'package:getx_supabase/app/data/provider/supabase_provider.dart';

import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final togglePassword = false.obs;

  void toggleShowPassword() {
    togglePassword.value = !togglePassword.value;
  }

  Future<void> signUp(String name, String email, String password) async {
    final user = await SupabaseProvider.instance.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
    if (user) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error signing up', 'Try again');
    }
  }
}

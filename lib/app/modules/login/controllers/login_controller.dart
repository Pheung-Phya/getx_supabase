import 'package:get/get.dart';
import 'package:getx_supabase/app/data/provider/supabase_provider.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final togglePassword = false.obs;

  void toggleShowPassword() {
    togglePassword.value = !togglePassword.value;
  }

  Future<void> login(String email, String password) async {
    final user = await SupabaseProvider.instance
        .loginWithEmail(email: email, password: password);
    if (user) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}

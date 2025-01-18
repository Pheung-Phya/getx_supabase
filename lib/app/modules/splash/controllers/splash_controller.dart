import 'package:get/get.dart';
import 'package:getx_supabase/app/data/provider/supabase_provider.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateScreen();
  }

  void _navigateScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = await SupabaseProvider.instance.getCurrentUser();
    if (user) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}

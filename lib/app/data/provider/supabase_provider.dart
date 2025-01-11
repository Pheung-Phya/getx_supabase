import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../routes/app_pages.dart';

class SupabaseProvider {
  static SupabaseProvider instance = SupabaseProvider._privateConstructor();
  SupabaseProvider._privateConstructor();
  final supabase = Supabase.instance.client;

  Future<void> loginWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await instance.supabase.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('Login Error', 'Error: ' + e.toString());
    }
  }

  Future<void> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await instance.supabase.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });
      if (user.session != null && !GetUtils.isEmail(email)) {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar('Login Error', 'Error: ' + e.toString());
    }
  }
}

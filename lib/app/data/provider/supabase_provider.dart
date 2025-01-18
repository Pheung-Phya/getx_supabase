import 'dart:ffi';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../routes/app_pages.dart';

class SupabaseProvider {
  static SupabaseProvider instance = SupabaseProvider._privateConstructor();
  SupabaseProvider._privateConstructor();
  final supabase = Supabase.instance.client;

  Future<bool> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await instance.supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      Get.snackbar("Erorr", 'Erorr ${e.toString()}');
      return false;
    }
  }

  Future<bool> signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final response = await instance.supabase.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });
      if (response.user != null) {
        return true;
      } else {
        throw Exception('Sign-up failed');
      }
    } catch (e) {
      print('Sign-up error: $e');
      return false;
    }
  }

  Future<bool> getCurrentUser() async {
    final user = instance.supabase.auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await instance.supabase.auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Failed to sign out: $e');
    }
  }
}

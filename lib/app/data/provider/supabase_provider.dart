import 'dart:io';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../routes/app_pages.dart';

class SupabaseProvider {
  static SupabaseProvider instance = SupabaseProvider._privateConstructor();
  SupabaseProvider._privateConstructor();
  final supabase = Supabase.instance.client;

  Future<String?> uploadImage(File file, String bucket, String path) async {
    try {
      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final bytes = await file.readAsBytes();

      final response = await supabase.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(contentType: mimeType),
          );
      if (response.error != null) {
        Get.snackbar(
            "Error", "Failed to upload image: ${response.error?.message}");
        return null;
      }
      final publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
      print("Uploaded Image URL: $publicUrl"); // Debugging log
      return publicUrl;
    } catch (e) {
      Get.snackbar("Error", "Image upload failed: $e");
      print("Image upload failed: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> saveProductToSupabase(
      Map<String, dynamic> product) async {
    try {
      final response =
          await supabase.from('products').insert([product]).select().single();
      return response;
    } catch (e) {
      print('Error saving product: $e');
      return null;
    }
  }

  Future<bool> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.session != null;
    } catch (e) {
      Get.snackbar("Error", 'Error ${e.toString()}');
      return false;
    }
  }

  Future<bool> signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final response = await supabase.auth
          .signUp(email: email, password: password, data: {'name': name});
      return response.user != null;
    } catch (e) {
      print('Sign-up error: $e');
      return false;
    }
  }

  Future<bool> getCurrentUser() async {
    final user = supabase.auth.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Failed to sign out: $e');
    }
  }
}

extension on PostgrestList {
  get error => null;
}

extension on String {
  get error => null;
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider {
  static SupabaseProvider instance = SupabaseProvider._privateConstructor();
  SupabaseProvider._privateConstructor();
  final supabase = Supabase.instance.client;
  Future<String?> uploadImage(File file, String bucket, String path) async {
    try {
      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final bytes = await file.readAsBytes();

      await supabase.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(contentType: mimeType),
          );
      final publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      Get.snackbar("Error", "Image upload failed: $e");
      print("Image upload failed: $e");
      return null;
    }
  }

  Future<bool> saveProductToSupabase(Map<String, dynamic> product) async {
    try {
      final response = await supabase.from('products').insert(product).select();
      if (response.isEmpty) {
        throw Exception("Failed to save product. No data returned.");
      }
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to save product to Supabase: $e");
      print("Failed to save product to Supabase: $e");
      return false;
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
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Failed to sign out: $e');
    }
  }
}

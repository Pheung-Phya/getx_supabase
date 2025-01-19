import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/provider/supabase_provider.dart';

class AddproductController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageFile = Rx<File?>(null);
  final selectedSizes = <String>[].obs;
  final selectedColors = <String>[].obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> saveProduct() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar("Error", "Name and price are required");
      return;
    }

    String? imageUrl;
    if (imageFile.value != null) {
      final fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';
      imageUrl = await SupabaseProvider.instance.uploadImage(
        imageFile.value!,
        'product_image',
        fileName,
      );

      if (imageUrl == null) {
        Get.snackbar("Error", "Failed to upload image");
        return;
      }
    }

    final product = {
      'name': nameController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
      'size': selectedSizes,
      'color': selectedColors,
      'description': descriptionController.text,
      'image': imageUrl,
      'quantity': 0,
    };

    final isSaved =
        await SupabaseProvider.instance.saveProductToSupabase(product);
    if (isSaved) {
      Get.snackbar("Success", "Product saved in Supabase");
    } else {
      Get.snackbar("Error", "Failed to save product to Supabase");
    }
  }
}

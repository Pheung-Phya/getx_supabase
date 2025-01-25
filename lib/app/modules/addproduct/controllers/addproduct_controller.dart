import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/provider/supabase_provider.dart';
import '../../home/controllers/home_controller.dart';

class AddproductController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageFile = Rx<File?>(null);
  final selectedSizes = <String>[].obs;
  final selectedColors = <String>[].obs;

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageFile.value = null;
    selectedSizes.clear();
    selectedColors.clear();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> saveProduct() async {
    if (imageFile.value == null ||
        selectedSizes.isEmpty ||
        selectedColors.isEmpty) {
      Get.snackbar(
        "Error",
        "At least one size and color should be selected. Image is required.",
      );
      return;
    }
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar("Error", "Name and price are required.");
      return;
    }

    double price = double.tryParse(priceController.text) ?? 0.0;
    if (price == 0.0) {
      Get.snackbar("Error", "Price must be a valid number.");
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
        Get.snackbar("Error", "Failed to upload image.");
        return;
      }
    }

    final product = {
      'name': nameController.text,
      'price': price,
      'size': selectedSizes,
      'color': selectedColors,
      'description': descriptionController.text,
      'image': imageUrl,
      'quantity': 0,
    };

    final response =
        await SupabaseProvider.instance.saveProductToSupabase(product);
    if (response != null && response['id'] != null) {
      final productId = response['id']; // Get the product id from the response
      product['id'] = productId; // Assign the id to the product

      // Add the new product to HomeController's list
      Get.find<HomeController>().products.add(product);
      Get.snackbar("Success", "Product saved in Supabase.");
    } else {
      Get.snackbar("Error", "Failed to save product to Supabase.");
    }
    clearField();
    Get.back();
  }

  void clearField() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    imageFile.value = null;
    selectedSizes.clear();
    selectedColors.clear();
  }
}

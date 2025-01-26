import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_supabase/app/modules/home/controllers/home_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/product.dart';
import '../../../data/provider/supabase_provider.dart';

class UpdateProductController extends GetxController {
  var imageFile = Rxn<File>();
  var imageUrl = Rxn<String>();
  var selectedSizes = <String>[].obs;
  var selectedColors = <String>[].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  int? productId;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Product) {
      Product product = Get.arguments;
      productId = product.id!;
      loadProductData(product);
      print('Product loaded with ID: $productId');
    } else {
      Get.snackbar('Error', 'Invalid product data');
      print('Get.arguments: ${Get.arguments}');
    }
  }

  void loadProductData(Product product) {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    descriptionController.text = product.description ?? '';
    selectedSizes.assignAll(product.sizes);
    selectedColors.assignAll(product.colors);

    if (product.image.isNotEmpty && product.image.startsWith('http')) {
      imageUrl.value = product.image;
    } else if (product.image != null) {
      imageFile.value = File(product.image);
    }
  }

  Future<void> updateProduct(int id) async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedSizes.isEmpty ||
        selectedColors.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    try {
      double? price = double.tryParse(priceController.text);
      if (price == null) {
        Get.snackbar('Error', 'Invalid price format');
        return;
      }

      String? imageUrlToUpdate = imageUrl.value;
      if (imageFile.value != null) {
        imageUrlToUpdate = await SupabaseProvider.instance.uploadImage(
          imageFile.value!,
          'product_image',
          'products/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        if (imageUrlToUpdate == null) {
          Get.snackbar('Error', 'Image upload failed');
          return;
        }
        print('Image uploaded: $imageUrlToUpdate');
      }

      if (imageUrlToUpdate == null) {
        Get.snackbar('Error', 'Please upload an image');
        return;
      }

      var response = await SupabaseProvider.instance.updateProductInSupabase(
        id: id,
        name: nameController.text,
        price: price,
        quantity: 0,
        description: descriptionController.text,
        size: selectedSizes,
        color: selectedColors,
        imageUrl: imageUrlToUpdate,
      );

      if (response != null && response) {
        Get.snackbar('Success', 'Product updated successfully');
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update product');
        // print('API Response: ${response.error ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error while updating product: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    }
    Get.find<HomeController>().fetchProducts();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await showDialog<XFile>(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Image Source'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  final file =
                      await picker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context, file);
                },
                child: const Text('Camera'),
              ),
              TextButton(
                onPressed: () async {
                  final file =
                      await picker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context, file);
                },
                child: const Text('Gallery'),
              ),
            ],
          );
        });

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageUrl.value = null;
    }
  }
}

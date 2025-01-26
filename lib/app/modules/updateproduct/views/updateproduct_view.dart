import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/updateproduct_controller.dart';

class UpdateProductView extends GetView<UpdateProductController> {
  const UpdateProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Sizes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Wrap(
                spacing: 8.0,
                children: ['S', 'M', 'L', 'XL', 'XXL']
                    .map(
                      (size) => FilterChip(
                        label: Text(size),
                        selected: controller.selectedSizes.contains(size),
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.selectedSizes.add(size);
                          } else {
                            controller.selectedSizes.remove(size);
                          }
                        },
                      ),
                    )
                    .toList(),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Select Colors:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Wrap(
                spacing: 8.0,
                children: ['Red', 'Blue', 'Green', 'Black', 'White']
                    .map(
                      (color) => FilterChip(
                        label: Text(color),
                        selected: controller.selectedColors.contains(color),
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.selectedColors.add(color);
                          } else {
                            controller.selectedColors.remove(color);
                          }
                        },
                      ),
                    )
                    .toList(),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Upload Image:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: controller.imageFile.value != null
                      ? Image.file(
                          controller.imageFile.value!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : controller.imageUrl.value != null
                          ? Image.network(
                              controller.imageUrl.value!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                ),
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.productId != null) {
                    controller.updateProduct(controller.productId!);
                  } else {
                    Get.snackbar('Error', 'Product ID is missing');
                    print('Product ID is missing');
                  }
                },
                child: const Text('Update Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

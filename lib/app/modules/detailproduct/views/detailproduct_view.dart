import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detailproduct_controller.dart';

class DetailproductView extends GetView<DetailproductController> {
  const DetailproductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.product.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final product = controller.product;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product['image'] != null
                    ? Image.network(
                        product['image'],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
                const SizedBox(height: 16),
                Text(
                  'Name: ${product['name'] ?? 'No name'}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Price: \$${product['price']}'),
                const SizedBox(height: 8),
                Text('Quantity: ${product['quantity']}'),
                const SizedBox(height: 8),
                Text(
                  'Description: ${product['description'] ?? 'No description available.'}',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.UPDATEPRODUCT, arguments: product);
                  },
                  child: const Text('Edit Product'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

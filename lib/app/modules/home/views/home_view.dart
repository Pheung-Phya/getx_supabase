import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/model/product.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADDPRODUCT);
            },
            icon: const Icon(
              Icons.add,
              size: 32,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text("No products available."));
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final productData = controller.products[index];
              final product =
                  Product.fromMap(productData); // Convert Map to Product

              return Card(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  leading: product.image != null
                      ? Image.network(
                          product.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Get.toNamed(Routes.UPDATEPRODUCT, arguments: product);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteProduct(product.id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

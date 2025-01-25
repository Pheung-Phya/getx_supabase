import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_supabase/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/drawer_field.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerField(),
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
              final product = controller.products[index];
              return Card(
                child: ListTile(
                  title: Text(product['name'] ?? 'No name'),
                  subtitle: Text('Price: \$${product['price']}'),
                  leading: product['image'] != null
                      ? Image.network(
                          product['image'],
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
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteProduct(product['id']);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed(Routes.DETAILPRODUCT, arguments: product);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}

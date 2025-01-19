// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_supabase/app/modules/widgets/drawer_field.dart';
// import '../../../routes/app_pages.dart';
// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const DrawerField(),
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.toNamed(Routes.ADDPRODUCT);
//             },
//             icon: const Icon(
//               Icons.add,
//               size: 32,
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.products.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: controller.products.length,
//             itemBuilder: (context, index) {
//               final product = controller.products[index];
//               return ListTile(
//                 title: Text(product['name'] ?? 'No name'),
//                 subtitle: Text('Price: \$${product['price']}'),
//                 leading: product['image'] != null
//                     ? Image.network(product['image'])
//                     : null,
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
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
        if (controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ListTile(
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
              );
            },
          );
        }
      }),
    );
  }
}

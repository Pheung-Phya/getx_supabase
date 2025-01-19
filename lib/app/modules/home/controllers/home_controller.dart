// import 'package:get/get.dart';
// import 'package:getx_supabase/app/data/provider/supabase_provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class HomeController extends GetxController {
//   RxList<Map<String, dynamic>> products = RxList<Map<String, dynamic>>([]);

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     try {
//       final response =
//           await SupabaseProvider.instance.supabase.from('products').select();

//       print('Response Data: ${response}');

//       if (response.error != null) {
//         Get.snackbar(
//             "Error", "Failed to fetch products: ${response.error?.message}");
//       } else {
//         final data = response;

//         products.assignAll(List<Map<String, dynamic>>.from(data));
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
// }

// extension on PostgrestList {
//   get error => null;
// }

import 'package:get/get.dart';
import 'package:getx_supabase/app/data/provider/supabase_provider.dart';

class HomeController extends GetxController {
  RxList<Map<String, dynamic>> products = RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    setupRealtimeUpdates();
  }

  Future<void> fetchProducts() async {
    try {
      final data =
          await SupabaseProvider.instance.supabase.from('products').select();

      products.assignAll(List<Map<String, dynamic>>.from(data));
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching products: $e");
    }
  }

  void setupRealtimeUpdates() {
    SupabaseProvider.instance.supabase
        .from('products')
        .stream(primaryKey: ['id']).listen((event) {
      products.assignAll(
        event.map((e) => e as Map<String, dynamic>).toList(),
      );
    });
  }
}

// import 'dart:ffi';
// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:mime/mime.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../routes/app_pages.dart';

// class SupabaseProvider {
//   static SupabaseProvider instance = SupabaseProvider._privateConstructor();
//   SupabaseProvider._privateConstructor();
//   final supabase = Supabase.instance.client;

//   Future<String?> uploadImage(File file, String bucket, String path) async {
//     try {
//       final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
//       final bytes = await file.readAsBytes();

//       final response = await supabase.storage.from(bucket).uploadBinary(
//             path,
//             bytes,
//             fileOptions: FileOptions(contentType: mimeType),
//           );

//       if (response.error != null) {
//         throw Exception(response.error!.message);
//       }

//       final publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
//       return publicUrl;
//     } catch (e) {
//       Get.snackbar("Error", "Image upload failed: $e");
//       return null;
//     }
//   }

//   Future<bool> saveProductToSupabase(Map<String, dynamic> product) async {
//     try {
//       final response = await supabase.from('products').insert(product);
//       if (response.error != null) {
//         throw Exception(response.error!.message);
//       }
//       return true;
//     } catch (e) {
//       Get.snackbar("Error", "Failed to save product to Supabase: $e");
//       return false;
//     }
//   }

//   Future<bool> loginWithEmail(
//       {required String email, required String password}) async {
//     try {
//       final response = await instance.supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );
//       if (response.session != null) {
//         return true;
//       } else {
//         throw Exception('Invalid credentials');
//       }
//     } catch (e) {
//       Get.snackbar("Erorr", 'Erorr ${e.toString()}');
//       return false;
//     }
//   }

//   Future<bool> signUpWithEmail(
//       {required String email,
//       required String password,
//       required String name}) async {
//     try {
//       final response = await instance.supabase.auth
//           .signUp(email: email, password: password, data: {
//         'name': name,
//       });
//       if (response.user != null) {
//         return true;
//       } else {
//         throw Exception('Sign-up failed');
//       }
//     } catch (e) {
//       print('Sign-up error: $e');
//       return false;
//     }
//   }

//   Future<bool> getCurrentUser() async {
//     final user = instance.supabase.auth.currentUser;
//     if (user != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await instance.supabase.auth.signOut();
//       Get.offAllNamed(Routes.LOGIN);
//     } catch (e) {
//       print('Error signing out: $e');
//       throw Exception('Failed to sign out: $e');
//     }
//   }
// }





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../data/provider/supabase_provider.dart';

// class AddproductController extends GetxController {
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//   final descriptionController = TextEditingController();

//   final imageFile = Rx<File?>(null);
//   final selectedSize = ''.obs;
//   final selectedColor = ''.obs;

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       imageFile.value = File(pickedFile.path);
//     }
//   }

//   Future<void> saveProduct() async {
//     if (nameController.text.isEmpty || priceController.text.isEmpty) {
//       Get.snackbar("Error", "Name and price are required");
//       return;
//     }

//     // Upload image to Supabase
//     String? imageUrl;
//     if (imageFile.value != null) {
//       final fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       imageUrl = await SupabaseProvider.instance.uploadImage(
//         imageFile.value!,
//         'product_image', // Supabase bucket name
//         fileName,
//       );

//       if (imageUrl == null) {
//         Get.snackbar("Error", "Failed to upload image");
//         return;
//       }
//     }

//     // Prepare product data with arrays for sizes and colors
//     final product = {
//       'name': nameController.text,
//       'price': double.tryParse(priceController.text) ?? 0.0,
//       'size': [selectedSize.value],
//       'color': [selectedColor.value],
//       'description': descriptionController.text,
//       'image': imageUrl,
//       'quantity': 0, // Ensure quantity is set
//     };

//     // Save product in Supabase table
//     final isSaved =
//         await SupabaseProvider.instance.saveProductToSupabase(product);
//     if (isSaved) {
//       Get.snackbar("Success", "Product saved in Supabase");
//     } else {
//       Get.snackbar("Error", "Failed to save product to Supabase");
//     }
//   }
// }





// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import '../controllers/addproduct_controller.dart';

// class AddproductView extends GetView<AddproductController> {
//   AddproductView({super.key});

//   List<String> sizes = ['S', 'M', 'X', 'XL', 'XXL'];
//   List<String> color = [
//     'Black',
//     'Red',
//     'Green',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Addproduct'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.shopping_cart_outlined,
//               size: 30,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 200,
//                   width: 200,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: const Color.fromARGB(255, 27, 62, 218)),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset('assets/images/logostar.png')),
//                 ),
//                 space(20),
//                 const TextField(
//                   decoration: InputDecoration(
//                       label: Text('Enter Product Name'),
//                       border: OutlineInputBorder()),
//                 ),
//                 space(15),
//                 const TextField(
//                   keyboardType: TextInputType.numberWithOptions(),
//                   decoration: InputDecoration(
//                       prefix: Text('\$'),
//                       label: Text(' Enter Product price'),
//                       border: OutlineInputBorder()),
//                 ),
//                 space(15),
//                 SizedBox(
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(3.5),
//                         width: 70,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3),
//                           color: Colors.red,
//                         ),
//                         child: const Text(
//                           ' Sizes',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             itemCount: sizes.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(7.0),
//                                 child: MaterialButton(
//                                   color: Colors.blue,
//                                   onPressed: () {},
//                                   child: Text(sizes[index]),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//                 space(15),
//                 SizedBox(
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(3.5),
//                         width: 70,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3),
//                           color: Colors.red,
//                         ),
//                         child: const Text(
//                           'Colors',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             itemCount: color.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(7.0),
//                                 child: MaterialButton(
//                                   color: Colors.blue,
//                                   onPressed: () {},
//                                   child: Text(color[index]),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//                 space(15),
//                 const TextField(
//                   maxLines: 12,
//                   decoration: InputDecoration(
//                       hintText: 'Enter Product decoration',
//                       border: OutlineInputBorder()),
//                 ),
//                 space(15),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget space(double height) {
//     return SizedBox(
//       height: height,
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/addproduct_controller.dart';

// class AddproductView extends GetView<AddproductController> {
//   AddproductView({super.key});

//   final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
//   final List<String> colors = ['Black', 'Red', 'Green'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Obx(() {
//                 return controller.imageFile.value != null
//                     ? Image.file(controller.imageFile.value!, height: 200)
//                     : const Text("No Image Selected");
//               }),
//               ElevatedButton(
//                 onPressed: controller.pickImage,
//                 child: const Text("Pick Image"),
//               ),
//               TextField(
//                 controller: controller.nameController,
//                 decoration: const InputDecoration(labelText: 'Product Name'),
//               ),
//               TextField(
//                 controller: controller.priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Price'),
//               ),
//               DropdownButton<String>(
//                 value: controller.selectedSize.value.isEmpty
//                     ? null
//                     : controller.selectedSize.value,
//                 hint: const Text("Select Size"),
//                 onChanged: (value) {
//                   controller.selectedSize.value = value!;
//                 },
//                 items: sizes
//                     .map((size) => DropdownMenuItem(
//                           value: size,
//                           child: Text(size),
//                         ))
//                     .toList(),
//               ),
//               DropdownButton<String>(
//                 value: controller.selectedColor.value.isEmpty
//                     ? null
//                     : controller.selectedColor.value,
//                 hint: const Text("Select Color"),
//                 onChanged: (value) {
//                   controller.selectedColor.value = value!;
//                 },
//                 items: colors
//                     .map((color) => DropdownMenuItem(
//                           value: color,
//                           child: Text(color),
//                         ))
//                     .toList(),
//               ),
//               TextField(
//                 controller: controller.descriptionController,
//                 maxLines: 5,
//                 decoration:
//                     const InputDecoration(labelText: 'Product Description'),
//               ),
//               ElevatedButton(
//                 onPressed: controller.saveProduct,
//                 child: const Text("Save Product"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


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
//       // Perform the select query without execute()
//       final response = await SupabaseProvider.instance.supabase
//           .from('products')
//           .select()
//           .single(); // single() ensures we get only one record, or change to .many() for multiple

//       // Print the response data for debugging
//       print('Response Data: ${response}');

//       if (response != null) {
//         // Handle error if the query failed
//         Get.snackbar("Error", "Failed to fetch products: ${response}");
//         print("Failed to fetch products: ${response}");
//       } else {
//         // Ensure the response.data is a List
//         final data = response;

//         if (data is List) {
//           // If data is a list, cast it to List<Map<String, dynamic>> and assign
//           products.assignAll(List<Map<String, dynamic>>.from(data.values));
//         } else if (data is Map) {
//           // Handle the case where data is a Map (if applicable)
//           Get.snackbar("Error", "Unexpected data format: Map instead of List.");
//         } else {
//           // Handle unexpected data types
//           Get.snackbar("Error", "Unexpected data format.");
//         }
//       }
//     } catch (e) {
//       // Catch any unexpected errors
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
// }

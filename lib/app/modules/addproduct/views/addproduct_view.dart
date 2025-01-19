import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addproduct_controller.dart';

class AddproductView extends GetView<AddproductController> {
  AddproductView({super.key});

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> colors = ['Black', 'Red', 'Green'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.saveProduct;
                Get.back();
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return controller.imageFile.value != null
                    ? Image.file(controller.imageFile.value!, height: 200)
                    : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(child: Text("No Image Selected")));
              }),
              space(15),
              ElevatedButton(
                onPressed: controller.pickImage,
                child: const Text("Pick Image"),
              ),
              space(15),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Product Name'),
              ),
              space(15),
              TextField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    border: OutlineInputBorder(),
                    labelText: 'Product Price'),
              ),
              space(15),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const Text('Sizes'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: sizes.map((size) {
                          return Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(size),
                                selected:
                                    controller.selectedSizes.contains(size),
                                onSelected: (selected) {
                                  if (selected) {
                                    controller.selectedSizes.add(size);
                                  } else {
                                    controller.selectedSizes.remove(size);
                                  }
                                },
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              space(15),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const Text('Colors'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: colors.map((color) {
                          return Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(color),
                                selected:
                                    controller.selectedColors.contains(color),
                                onSelected: (selected) {
                                  if (selected) {
                                    controller.selectedColors.add(color);
                                  } else {
                                    controller.selectedColors.remove(color);
                                  }
                                },
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              space(15),
              TextField(
                controller: controller.descriptionController,
                maxLines: 12,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Description'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height,
    );
  }
}

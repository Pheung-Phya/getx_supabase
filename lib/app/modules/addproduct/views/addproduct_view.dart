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
              controller.saveProduct();
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          )
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(child: Text("No Image Selected")),
                      );
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
                  border: OutlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
              space(15),
              TextField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.attach_money_sharp),
                  border: OutlineInputBorder(),
                  labelText: 'Product Price',
                ),
              ),
              space(15),
              buildChoiceChips('Sizes', sizes, controller.selectedSizes),
              space(15),
              buildChoiceChips('Colors', colors, controller.selectedColors),
              space(15),
              TextField(
                controller: controller.descriptionController,
                maxLines: 12,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Description',
                ),
              ),
              space(15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChoiceChips(
      String label, List<String> options, RxList<String> selectedItems) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: Text(label),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options.map((option) {
                return Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(option),
                      selected: selectedItems.contains(option),
                      onSelected: (selected) {
                        if (selected) {
                          selectedItems.add(option);
                        } else {
                          selectedItems.remove(option);
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
    );
  }

  Widget space(double height) {
    return SizedBox(height: height);
  }
}

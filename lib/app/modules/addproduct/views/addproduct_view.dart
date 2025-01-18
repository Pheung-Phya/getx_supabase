import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/addproduct_controller.dart';

class AddproductView extends GetView<AddproductController> {
  AddproductView({super.key});

  List<String> sizes = ['S', 'M', 'X', 'XL', 'XXL'];
  List<String> color = [
    'Black',
    'Red',
    'Green',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addproduct'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 27, 62, 218)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/images/logostar.png')),
                ),
                space(20),
                const TextField(
                  decoration: InputDecoration(
                      label: Text('Enter Product Name'),
                      border: OutlineInputBorder()),
                ),
                space(15),
                const TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      prefix: Text('\$'),
                      label: Text(' Enter Product price'),
                      border: OutlineInputBorder()),
                ),
                space(15),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.5),
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.red,
                        ),
                        child: const Text(
                          ' Sizes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: sizes.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () {},
                                  child: Text(sizes[index]),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                space(15),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.5),
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.red,
                        ),
                        child: const Text(
                          'Colors',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: color.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () {},
                                  child: Text(color[index]),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                space(15),
                const TextField(
                  maxLines: 12,
                  decoration: InputDecoration(
                      hintText: 'Enter Product decoration',
                      border: OutlineInputBorder()),
                ),
                space(15),
              ],
            ),
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

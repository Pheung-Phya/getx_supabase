import 'package:get/get.dart';

class DetailproductController extends GetxController {
  // Declare product details as observable
  var product = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Optionally, fetch the product details if needed
    final productData = Get.arguments;
    if (productData != null) {
      product.value = productData;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

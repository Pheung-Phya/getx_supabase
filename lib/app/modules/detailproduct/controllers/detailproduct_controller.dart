import 'package:get/get.dart';

class DetailproductController extends GetxController {
  var product = {}.obs;

  @override
  void onInit() {
    super.onInit();
    final productData = Get.arguments;
    if (productData != null) {
      product.value = productData;
    }
  }
}

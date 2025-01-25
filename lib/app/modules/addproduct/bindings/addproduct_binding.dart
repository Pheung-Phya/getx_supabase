import 'package:get/get.dart';

import '../controllers/addproduct_controller.dart';

class AddproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AddproductController(),
    );
  }
}

import 'package:get/get.dart';
import '../controllers/updateproduct_controller.dart';

class UpdateproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProductController>(
      () => UpdateProductController(),
    );
  }
}

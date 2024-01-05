import 'package:erg_diagnosis/controllers/home_page_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController(), permanent: true);
  }
}

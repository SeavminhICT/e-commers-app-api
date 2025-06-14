import 'package:e_commers_app/data/model/provider/api_provider.dart';
import 'package:get/get.dart';

class APIBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
  }
}

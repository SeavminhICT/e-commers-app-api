import 'package:e_commers_app/service/storage_service.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  var currentUser;

  final count = 0.obs;

  @override
  void onInit() {
    getCurrentUserLoggedIn();
    super.onInit();
  }

  void getCurrentUserLoggedIn() async {
    final user = await StorageService.read(key: 'user');
    currentUser = user;
    print('user $user');
  }
}

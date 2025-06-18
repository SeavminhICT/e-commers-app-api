import 'package:e_commers_app/module/model/products_detail_model.dart';
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

class FavoriteController extends GetxController {
  var favoriteProducts = <ProductsDetailModel>[].obs;

  void toggleFavorite(ProductsDetailModel product) {
    final exists =
        favoriteProducts.any((item) => item.productId == product.productId);
    if (exists) {
      favoriteProducts
          .removeWhere((item) => item.productId == product.productId);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(String id) =>
      favoriteProducts.any((item) => item.productId == id);
}

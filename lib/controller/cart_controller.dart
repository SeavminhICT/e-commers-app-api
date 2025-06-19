
import 'package:e_commers_app/data/model/cart.res.model.dart';
import 'package:e_commers_app/data/model/provider/api_provider.dart';
import 'package:e_commers_app/module/auth/login.dart';
import 'package:get/get.dart';



class CartController extends GetxController {
  final _provider = Get.find<ApiProvider>();
  var isLoading = false.obs;
  Rx<CartResponse> cart = Rx(CartResponse());
  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  void fetchCart() async {
    try {
      isLoading(true);
      final response = await _provider.getCartProducts();
      print("response cart ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = response.data;
        cart.value = CartResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        Get.to(SignInScreen(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500));
      } else {}
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
}

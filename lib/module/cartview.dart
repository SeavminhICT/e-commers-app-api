import 'package:e_commers_app/data/model/cart.res.model.dart';
import 'package:e_commers_app/module/api_service/api_service.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartResponse? _cartResponse;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final token = await StorageService.read(key: 'token');
      if (token == null) {
        // User is not logged in, maybe show a message or redirect
        setState(() => _isLoading = false);
        return;
      }

      // Create an instance of ApiService and call getCart as an instance method.
      final apiService = ApiService();
      final cart = await apiService.getCart(token);

      setState(() {
        _cartResponse = cart;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_cartResponse == null ||
        _cartResponse!.cart == null ||
        _cartResponse!.cart!.items == null ||
        _cartResponse!.cart!.items!.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: const Center(child: Text('Your cart is empty')),
      );
    }

    final items = _cartResponse!.cart!.items!;

    List<Widget> cartItems = items.map((item) {
      
      return ListTile(
        leading: (item.product?.image != null &&
                item.product!.image!.isNotEmpty)
            ? Image.network(
                item.product!.image!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              )
            : const Icon(Icons.image),
        title: Text(item.product?.name ?? 'Unknown'),
        subtitle: Text('Quantity: ${item.quantity}\nPrice: \$${item.price}'),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final product = item.product;

          return ListTile(
            leading: (product?.image != null && product!.image!.isNotEmpty)
                ? Image.network(
                    product.image!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  )
                : const Icon(Icons.image),
            title: Text(product?.name ?? 'Unknown'),
            subtitle:
                Text('Quantity: ${item.quantity}\nPrice: \$${item.price}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Text(
          'Total: \$${_cartResponse!.total}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  
}

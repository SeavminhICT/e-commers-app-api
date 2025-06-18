import 'package:e_commers_app/module/model/products_detail_model.dart';
import 'package:e_commers_app/module/products_detail_screen.dart';
import 'package:flutter/material.dart';
import 'model/product_model.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products;

  const ProductsScreen({super.key, required this.products});
  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildProductGrid(products),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.blue),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Products',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductsDetailScreen(
                      product: ProductsDetailModel.fromProductModel(product),
                    ),
                  ),
                );
              },
              child: _buildProductCard(products[index]));
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final String imageUrl = fixUrl(product.image);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade200, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite_border, color: Colors.blue),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "\$${product.price}",
              style: const TextStyle(color: Colors.red),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.star, color: Colors.amber, size: 16),
              ),
              const SizedBox(width: 0),
              Text(
                product.rating.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

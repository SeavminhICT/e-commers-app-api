import 'package:flutter/material.dart';

import 'api_service/api_service.dart';
import 'model/image_banners_model.dart'; // adjust path if needed

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late Future<List<ProductModel>> _productList;

  @override
  void initState() {
    super.initState();
    _productList = ApiService().getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _productList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    product.images.isNotEmpty ? product.images[0] : '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: Text(product.category.name.name), // Show enum name
                ),
              );
            },
          );
        },
      ),
    );
  }
}

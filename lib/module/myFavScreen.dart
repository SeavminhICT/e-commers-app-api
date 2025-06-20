import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/module/model/products_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class MyScreen extends StatelessWidget {
  final List<ProductsDetailModel> favoriteProducts;

  MyScreen({Key? key, required this.favoriteProducts}) : super(key: key);
  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: AppBar(title: Text(languageData.My_Favorite)), // Use translated string
      body: favoriteProducts.isEmpty
          ? Center(child: Text(languageData.No_favorite_p)) // Use translated string
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                // final imageUrl = product.productImageUrl;
                final String imageUrl = fixUrl(product.productImageUrl);
                print(imageUrl);

                return ListTile(
                  leading: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 50);
                          },
                        )
                      : const Icon(Icons.image_not_supported, size: 50),
                  title: Text(product.productName),
                  subtitle: Text("\$${product.productPrice}"),
                );
              },
            ),
    );
  }
}

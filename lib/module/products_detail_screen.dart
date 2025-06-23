import 'package:e_commers_app/module/api_service/api_service.dart';
import 'package:e_commers_app/module/model/products_detail_model.dart';
import 'package:e_commers_app/module/myFavScreen.dart';
import 'package:e_commers_app/service/favorite_service.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class ProductsDetailScreen extends StatefulWidget {
  final ProductsDetailModel product;

  const ProductsDetailScreen({super.key, required this.product});

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  int selectedSize = 0;
  final List<int> availableSizes = [8, 10, 38, 40];

  // List<ProductsDetailModel> favoriteProducts = [];

  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    isFavorited = favoriteProducts.any(
      (item) => item.productId == widget.product.productId,
    );
  }
    Language _language = Language();
  int _langIndex = 0;

  Widget build(BuildContext context) {
    _language = context.watch<LanguageLogic>().language;
    _langIndex = context.watch<LanguageLogic>().langIndex;
    final product = widget.product;
    final imageUrl = fixUrl(product.productImageUrl);

    if (imageUrl.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Image URL is empty')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Image with icons (Back & Favorite)
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24)),
                  child: Image.network(
                    imageUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 50,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited = !isFavorited;

                        final detail =
                            product; // assuming `product` is already a ProductsDetailModel

                        if (isFavorited) {
                          favoriteProducts.add(detail);
                        } else {
                          favoriteProducts.removeWhere(
                              (item) => item.productId == detail.productId);
                        }
                      });
                    },
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "\$${product.productPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(_language.Size,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Wrap(
                      spacing: 12,
                      children: availableSizes.map((size) {
                        final isSelected = selectedSize == size;
                        return ChoiceChip(
                          label: Text(size.toString()),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          selectedColor: Colors.blue,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Text(_language.Description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      product.productDescription,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Buy Now + Add to Cart
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Future feature: handle "Buy Now"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _language.Buy_Now,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final token = await StorageService.read(key: 'token');
                        print(token);

                        if (token == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(_language.You_must)),
                          );

                          return;
                        }
                        final success = await ApiService.addToCart(
                          productId: int.parse(widget.product.productId),
                          quantity: 1,
                          authToken: token,
                          price: double.parse(
                              product.productPrice.toString()), // if needed
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                  ? _language.Add_to
                                  : _language.Failed_to),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _language.Add_to,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

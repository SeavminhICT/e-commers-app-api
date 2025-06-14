import 'package:e_commers_app/module/model/product_model.dart';

class ProductsDetailModel {
  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImageUrl;
  final int rating;

  ProductsDetailModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImageUrl,
    required this.rating,
  });

  factory ProductsDetailModel.fromProductModel(Product product) {
    return ProductsDetailModel(
      productId: product.id.toString(),
      productName: product.name,
      productDescription: product.description,
      productPrice: double.parse(product.price),
      productImageUrl: product.image,
      rating: product.rating,
    );
  }
}

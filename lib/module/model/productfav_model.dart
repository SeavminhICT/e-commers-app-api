import 'package:meta/meta.dart';
import 'dart:convert';

List<ProductFavModel> productFavModelFromJson(String str) =>
    List<ProductFavModel>.from(json.decode(str).map((x) => ProductFavModel.fromJson(x)));

String productFavModelToJson(List<ProductFavModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductFavModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  RatingFav rating;

  ProductFavModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductFavModel.fromJson(Map<String, dynamic> json) => ProductFavModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingFav.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

class RatingFav {
  double rate;
  int count;

  RatingFav({
    required this.rate,
    required this.count,
  });

  factory RatingFav.fromJson(Map<String, dynamic> json) => RatingFav(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
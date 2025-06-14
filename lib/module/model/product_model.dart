// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    bool success;
    List<Category> categories;
    List<dynamic> featuredProducts;

    ProductsModel({
        required this.success,
        required this.categories,
        required this.featuredProducts,
    });

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        success: json["success"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        featuredProducts: List<dynamic>.from(json["featuredProducts"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "featuredProducts": List<dynamic>.from(featuredProducts.map((x) => x)),
    };
}

class Category {
    int id;
    String name;
    List<Product> products;

    Category({
        required this.id,
        required this.name,
        required this.products,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    int id;
    String name;
    String description;
    String price;
    String image;
    dynamic isFeatured;
    int rating;
    dynamic createdAt;
    dynamic updatedAt;

    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.image,
        required this.isFeatured,
        required this.rating,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        isFeatured: json["is_featured"],
        rating: json["rating"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "is_featured": isFeatured,
        "rating": rating,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

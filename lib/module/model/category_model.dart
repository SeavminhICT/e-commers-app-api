import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool success;
  String message;
  List<Category_main> categories;

  CategoryModel({
    required this.success,
    required this.message,
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json["Success"],
        message: json["message"],
        categories: List<Category_main>.from(
            json["categories"].map((x) => Category_main.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "message": message,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category_main {
  int id;
  String name;
  dynamic description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Category_main({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category_main.fromJson(Map<String, dynamic> json) => Category_main(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

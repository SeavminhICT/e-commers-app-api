import 'package:get/get_utils/src/platform/platform.dart';

const kNOImgUrl =
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

var kBaseUrl =
    "http://${GetPlatform.isAndroid ? "10.0.2.2:8000/api" : "localhost:8000/api"}";

var kUrl =
    "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:8000/storage";

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? confremPassword;
  final String? avatar;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.confremPassword,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      confremPassword: json['confrem_password'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

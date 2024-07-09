
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

abstract class UserBaseModel {}

class UserLoadingModel extends UserBaseModel{}

@JsonSerializable()
class UserModel extends UserBaseModel{
  final String id;
  final String username;
  final String imageUrl;

  UserModel({required this.id, required this.username, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

}

class UserErrorModel extends UserBaseModel{}
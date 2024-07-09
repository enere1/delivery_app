import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel{
  final String accessToken;
  final String refreshToken;

  LoginModel({required this.accessToken, required this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
}

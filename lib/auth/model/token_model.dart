import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel{
  final String accessToken;

  TokenModel({required this.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
}

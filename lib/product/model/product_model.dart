import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final RestaurantItem restaurant;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToURL
  )
  final String imgUrl;
  final int price;

  ProductModel({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

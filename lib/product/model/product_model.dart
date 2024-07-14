import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductItem extends ModelWithId {

  final RestaurantItem restaurant;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToURL
  )
  final String imgUrl;
  final int price;

  ProductItem({
    required super.id,
    required this.restaurant,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
}

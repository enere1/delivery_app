import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantItem extends ModelWithId{

  final String name;
  @JsonKey(fromJson: DataUtils.pathToURL)
  final String thumbUrl;
  final List<String> tags;
  final String priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantItem(
      {required super.id,
      required this.name,
      required this.thumbUrl,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee});

  factory RestaurantItem.fromJson(Map<String, dynamic> json) =>
      _$RestaurantItemFromJson(json);

}
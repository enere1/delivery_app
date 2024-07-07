import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.g.dart';

abstract class RestaurantBaseModel {}

class RestaurantLoadingModel extends RestaurantBaseModel {}

@JsonSerializable()
class RestaurantModel extends RestaurantBaseModel {
  final Meta meta;
  final List<RestaurantItem> data;

  RestaurantModel({
    required this.meta,
    required this.data,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable()
class RestaurantItem {
  final String id;
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
      {required this.id,
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

class RestaurantFetchingMoreModel extends RestaurantModel {
  RestaurantFetchingMoreModel({required super.meta, required super.data});
}

class RestaurantReFetchingModel extends RestaurantModel {
  RestaurantReFetchingModel({required super.meta, required super.data});
}

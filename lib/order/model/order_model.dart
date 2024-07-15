import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  final String id;
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  OrderProductModel(
      {required this.id,
      required this.name,
      required this.detail,
      required this.imgUrl,
      required this.price});

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);
}

@JsonSerializable()
class OrderProdcutAndCountModel {
  final OrderProductModel product;
  final int count;

  OrderProdcutAndCountModel({required this.product, required this.count});

  factory OrderProdcutAndCountModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProdcutAndCountModelFromJson(json);
}

@JsonSerializable()
class OrderModel implements ModelWithId {
  final String id;
  final RestaurantItem restaurant;
  final List<OrderProdcutAndCountModel> products;
  final int totalPrice;
  @JsonKey(
    fromJson: DataUtils.StringToDateTime,
  )
  final DateTime createdAt;

  OrderModel(
      {required this.id,
      required this.restaurant,
      required this.products,
      required this.totalPrice,
      required this.createdAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}


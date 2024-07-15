import 'package:json_annotation/json_annotation.dart';

part 'basket_body_model.g.dart';

@JsonSerializable()
class BasketBodyModel {
  final List<BasketItem> basket;

  BasketBodyModel({required this.basket});

  factory BasketBodyModel.fromJson(Map<String, dynamic> json) =>
      _$BasketBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketBodyModelToJson(this);
}

@JsonSerializable()
class BasketItem {
  final String productId;
  final int count;

  BasketItem({required this.productId, required this.count});

  factory BasketItem.fromJson(Map<String, dynamic> json) =>
      _$BasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$BasketItemToJson(this);

  BasketItem copyWith({
    String? productId,
    int? count,
  }) =>
      BasketItem(
        productId: productId ?? this.productId,
        count: count ?? this.count,
      );
}

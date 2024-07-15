import 'package:delivery_app/product/model/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_model.g.dart';

@JsonSerializable()
class BasketModel {
  final ProductItem product;
  final int count;

  BasketModel({required this.product, required this.count});

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);

  BasketModel copyWith({
    ProductItem? product,
    int? count,
  }) =>
      BasketModel(
        product: product ?? this.product,
        count: count ?? this.count,
      );
}

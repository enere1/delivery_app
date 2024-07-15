// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBodyModel _$BasketBodyModelFromJson(Map<String, dynamic> json) =>
    BasketBodyModel(
      basket: (json['basket'] as List<dynamic>)
          .map((e) => BasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketBodyModelToJson(BasketBodyModel instance) =>
    <String, dynamic>{
      'basket': instance.basket,
    };

BasketItem _$BasketItemFromJson(Map<String, dynamic> json) => BasketItem(
      productId: json['productId'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$BasketItemToJson(BasketItem instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };

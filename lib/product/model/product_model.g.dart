// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as String,
      restaurant:
          RestaurantItem.fromJson(json['restaurant'] as Map<String, dynamic>),
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: DataUtils.pathToURL(json['imgUrl'] as String),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant': instance.restaurant,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantItem _$RestaurantItemFromJson(Map<String, dynamic> json) =>
    RestaurantItem(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbUrl: DataUtils.pathToURL(json['thumbUrl'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      priceRange: json['priceRange'] as String,
      ratings: (json['ratings'] as num).toDouble(),
      ratingsCount: (json['ratingsCount'] as num).toInt(),
      deliveryTime: (json['deliveryTime'] as num).toInt(),
      deliveryFee: (json['deliveryFee'] as num).toInt(),
    );

Map<String, dynamic> _$RestaurantItemToJson(RestaurantItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbUrl': instance.thumbUrl,
      'tags': instance.tags,
      'priceRange': instance.priceRange,
      'ratings': instance.ratings,
      'ratingsCount': instance.ratingsCount,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
    };

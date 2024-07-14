// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingItem _$RatingItemFromJson(Map<String, dynamic> json) => RatingItem(
      id: json['id'] as String,
      imgUrls: DataUtils.pathToURLForList(json['imgUrls'] as List),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String,
      rating: (json['rating'] as num).toInt(),
    );

Map<String, dynamic> _$RatingItemToJson(RatingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imgUrls': instance.imgUrls,
      'user': instance.user,
      'content': instance.content,
      'rating': instance.rating,
    };

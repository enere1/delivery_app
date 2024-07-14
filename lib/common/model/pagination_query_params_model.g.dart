// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_query_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationQueryParamsModel _$PaginationQueryParamsModelFromJson(
        Map<String, dynamic> json) =>
    PaginationQueryParamsModel(
      after: json['after'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationQueryParamsModelToJson(
        PaginationQueryParamsModel instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
    };

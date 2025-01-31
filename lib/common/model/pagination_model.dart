import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

class PaginationBaseModel {}

class PaginationLoadingModel extends PaginationBaseModel {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class PaginationModel<T> extends PaginationBaseModel {
  final Meta meta;
  final List<T> data;

  PaginationModel({
    required this.meta,
    required this.data,
  });

  factory PaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromjsonT) =>
      _$PaginationModelFromJson(json, fromjsonT);

  PaginationModel<T> copyWith({
    Meta? meta,
    List<T>? data,
  }) {
    return PaginationModel<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

class PaginationFetchingMoreModel<T> extends PaginationModel<T> {
  PaginationFetchingMoreModel({
    required super.meta,
    required super.data,
  });
}

class PaginationReFetchingModel<T> extends PaginationModel<T> {
  PaginationReFetchingModel({
    required super.meta,
    required super.data,
  });
}

class PaginationErrorModel extends PaginationBaseModel {}
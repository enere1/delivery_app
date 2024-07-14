import 'package:json_annotation/json_annotation.dart';

part 'pagination_query_params_model.g.dart';

@JsonSerializable()
class PaginationQueryParamsModel {
  final String? after;
  final int? count;

  const PaginationQueryParamsModel({
    this.after,
    this.count,
  });

  Map<String, dynamic> toJson() => _$PaginationQueryParamsModelToJson(this);

  PaginationQueryParamsModel copyWith({
    String? after,
    int? count,
  }) =>
      PaginationQueryParamsModel(
        after: after ?? this.after,
        count: count ?? this.count,
      );
}

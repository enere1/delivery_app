import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingItem extends ModelWithId {

  @JsonKey(
    fromJson: DataUtils.pathToURLForList
  )
  final List<String> imgUrls;
  final UserModel user;
  final String content;
  final int rating;

  RatingItem(
      {required super.id,
      required this.imgUrls,
      required this.user,
      required this.content,
      required this.rating});

  factory RatingItem.fromJson(Map<String, dynamic> json) =>
      _$RatingItemFromJson(json);
}

import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider = StateProvider.family((ref, String id){
  final dio = ref.watch(dioProvider);
  return RestaurantRatingRepository(dio, baseUrl: '$DOMAIN/restaurant/$id');
});

@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingItem> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/rating')
  @Headers({'accessToken': true})
  Future<PaginationModel<RatingItem>> paginate();
}

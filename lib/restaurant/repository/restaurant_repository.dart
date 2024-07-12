import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod/riverpod.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = StateProvider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final restaurantRepository =
      RestaurantRepository(dio, baseUrl: '$DOMAIN/restaurant');

  return restaurantRepository;
});

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('')
  @Headers({'accessToken': true})
  Future<PaginationModel<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({'accessToken': true})
  Future<RestaurantDetailModel> getRestaurantDetail(@Path('id') String id);

  @GET('/{id}/rating')
  Future<PaginationModel<RatingModel>> getRestaurantRating(@Path('id') String id);
}

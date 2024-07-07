import 'package:delivery_app/common/const/colors/ip.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod/riverpod.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = StateProvider<RestaurantRepository>((ref){
  final dio = ref.watch(dioProvider);
  final restaurantRepository = RestaurantRepository(
      dio, baseUrl: '$DOMAIN/restaurant'
  );

  return restaurantRepository;
});

@RestApi()
abstract class RestaurantRepository {

  factory RestaurantRepository(Dio dio, {String baseUrl}) = _RestaurantRepository;
  
  @GET('')
  @Headers({
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzIwMzU5NTc1LCJleHAiOjE3MjAzNTk4NzV9.TgpwI4oRBqe4cNQHuV4ChAIi7FJs-y4YQUSaWyFxAa8'
  })
  Future<RestaurantModel> getRestaurants();
}
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:delivery_app/restaurant/repository/restaurant_rating_repository.dart';
import 'package:delivery_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/pagination_provider.dart';


final restaurantRatingProvider = StateNotifierProvider.family<RestaurantRatingNotifier, PaginationBaseModel, String>((ref, id) {
  final repository = ref.watch(restaurantRatingRepositoryProvider(id));
  return RestaurantRatingNotifier(repository: repository);
});

class RestaurantRatingNotifier
    extends PaginationNotifier<RatingItem, RestaurantRatingRepository> {
  RestaurantRatingNotifier({required super.repository});
}

import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/repository/restaurant_repository.dart';
import 'package:riverpod/riverpod.dart';

final restaurantProvider = StateNotifierProvider<RestaurantNotifier, RestaurantBaseModel>((ref){
  final restaurantRepository = ref.watch(restaurantRepositoryProvider);
  return RestaurantNotifier(restaurantRepository: restaurantRepository);
});

class RestaurantNotifier extends StateNotifier<RestaurantBaseModel> {
  final RestaurantRepository restaurantRepository;

  RestaurantNotifier({
    required this.restaurantRepository,
  }) : super(RestaurantLoadingModel()) {
    paginate();
  }

  Future<RestaurantModel> paginate() async {
    final restaurantModel = await restaurantRepository.getRestaurants();
    state = restaurantModel;
    return restaurantModel;
  }
}

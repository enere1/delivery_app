import 'package:delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/repository/restaurant_repository.dart';
import 'package:riverpod/riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantItem, String>((ref, id) {
  final restaurant = ref.watch(restaurantProvider);
  final state = restaurant as RestaurantModel;
  return state.data.firstWhere((e) => e.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, RestaurantBaseModel>((ref) {
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

  Future<void> paginate() async {
    final restaurantModel = await restaurantRepository.getRestaurants();
    state = restaurantModel;
  }

  Future<void> getRestaurantDetail({
    required String id,
  }) async {
    final restaurantDetailModel =
        await restaurantRepository.getRestaurantDetail(id);

    if (state is! RestaurantModel) {
      return;
    }

    final pState = state as RestaurantModel;
    state = pState.copyWith(
        data: pState.data
            .map((e) =>
                e.id == restaurantDetailModel.id ? restaurantDetailModel : e)
            .toList());
  }
}

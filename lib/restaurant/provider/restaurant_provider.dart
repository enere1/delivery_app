import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantItem?, String>((ref, id) {
  final restaurant = ref.watch(restaurantProvider);
  final state = restaurant as PaginationModel<RestaurantItem>;
  return state.data.firstWhereOrNull((e) => e.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, PaginationBaseModel>((ref) {
  final restaurantRepository = ref.watch(restaurantRepositoryProvider);
  return RestaurantNotifier(repository: restaurantRepository);
});

class RestaurantNotifier
    extends PaginationNotifier<RestaurantItem, RestaurantRepository> {
  RestaurantNotifier({required super.repository});

  Future<void> getRestaurantDetail({
    required String id,
  }) async {
    final restaurantDetailModel = await repository.getRestaurantDetail(id);

    if (state is! PaginationModel) {
      return;
    }

    final pState = state as PaginationModel<RestaurantItem>;
    state = pState.copyWith(
        data: pState.data
            .map((e) =>
                e.id == restaurantDetailModel.id ? restaurantDetailModel : e)
            .toList());
  }
}

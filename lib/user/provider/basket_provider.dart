import 'package:delivery_app/product/model/product_model.dart';
import 'package:delivery_app/user/model/basket_body_model.dart';
import 'package:delivery_app/user/model/basket_model.dart';
import 'package:delivery_app/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketNotifier, List<BasketModel>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return BasketNotifier(repository: repository);
});

class BasketNotifier extends StateNotifier<List<BasketModel>> {
  final UserRepository repository;

  BasketNotifier({required this.repository}) : super([]){
    getBasket();
  }

  Future<void> patchBasket() async {
    final body = BasketBodyModel(
        basket: state
            .map((e) => BasketItem(productId: e.product.id, count: e.count))
            .toList());

    await repository.patchBasket(body);
  }

  Future<void> addItem(ProductItem item) async {
    final res = state.firstWhereOrNull((e) => e.product.id == item.id);
    //カートに存在しない場合
    if (res == null) {
      state = [
        ...state,
        BasketModel(
          product: item,
          count: 1,
        )
      ];
    } else {
      state = state
          .map((e) =>
              e.product.id == item.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    }

    await patchBasket();
  }

  Future<void> substractItem(ProductItem item) async {
    final res = state.firstWhereOrNull((e) => e.product.id == item.id);
    if (res == null) {
      return;
    }

    //カウントが0の場合
    if (res.count == 1) {
      state = state.where((e) => e.product.id != item.id).toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == item.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }

    await patchBasket();
  }

  Future<bool> getBasket() async {
    final res = await repository.getBasket();
    state = res;
    return true;
  }


}


import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/order/model/order_model.dart';
import 'package:delivery_app/order/model/post_order_body.dart';
import 'package:delivery_app/order/repository/order_repository.dart';
import 'package:delivery_app/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, PaginationBaseModel>((
    ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderNotifier(ref: ref, repository: repository);
});

class OrderNotifier extends PaginationNotifier<OrderModel, OrderRepository> {

  final Ref ref;

  OrderNotifier({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {

    final basket = ref.read(basketProvider);
    final uuid = Uuid();
    final id = uuid.v4();

    try {
      repository.postOrder(body: PostOrderBody(
        id: id,
        products: basket.map((e) =>
            PostOrderBodyProducts(
                productId: e.product.id,
                count: e.count
            )
        ).toList(),
        totalPrice: basket.fold<int>(0, (prev, next) {
          return prev + (next.product.price * next.count);
        }),
        createdAt: DateTime.now().toString(),
      ));
      return true;
    } catch (err) {
      print('OrderNotifier_postOrder error : ${err.toString()}');
      return false;
    }
  }
}

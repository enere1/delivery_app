
import 'package:delivery_app/common/component/pagination_view.dart';
import 'package:delivery_app/order/component/order_card.dart';
import 'package:delivery_app/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/order_model.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationView<OrderModel>(
        provider: orderProvider,
        builder: <OrderModel>(context, index, model) {
          return OrderCard.fromModel(model: model);
        }
    );
  }
}

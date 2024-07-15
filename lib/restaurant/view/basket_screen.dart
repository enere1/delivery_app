import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/order/provider/order_provider.dart';
import 'package:delivery_app/order/view/order_done_screen.dart';
import 'package:delivery_app/product/component/product_card.dart';
import 'package:delivery_app/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BasketScreen extends ConsumerStatefulWidget {
  static String get routeName => 'Basket';

  const BasketScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends ConsumerState<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(basketProvider);
    int basketCost = data.fold(0, (prev, next) {
      return prev + (next.product.price * next.count);
    });
    int deliveryFee = data.fold(0, (prev, next) {
      return prev + next.product.restaurant.deliveryFee;
    });

    if (data.length == 0) {
      return DefaultLayout(
        appBar: AppBar(
          title: Text('カート'),
        ),
        body: Center(
          child: Text('カートが空いてます。'),
        ),
      );
    }

    return DefaultLayout(
      appBar: AppBar(
        title: Text('カート'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final basketModel = data[index];
                    return ProductCard.fromBasketModel(
                      model: basketModel,
                      onSubtract: () async {
                        await ref
                            .read(basketProvider.notifier)
                            .substractItem(basketModel.product);
                      },
                      onAdd: () async {
                        await ref
                            .read(basketProvider.notifier)
                            .addItem(basketModel.product);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.0,
                    );
                  },
                  itemCount: data.length),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('お会計'),
                    Text(basketCost.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('配達費'),
                    Text(deliveryFee.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('総額'),
                    Text((basketCost + deliveryFee).toString()),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final res = await ref.read(orderProvider.notifier).postOrder();
                      if(res) {
                        context.goNamed(OrderDoneScreen.routeName);
                      }
                    },
                    child: Text(
                      '注文確定',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

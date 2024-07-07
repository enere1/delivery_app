import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(restaurantProvider);
    print(item);
    if (item is RestaurantLoadingModel) {
      return DefaultLayout(
        appBar: AppBar(
          title: Text(
            'レストラン一覧',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final restaurant = item as RestaurantModel;
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          'レストラン一覧',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final item = restaurant.data[index];
          return RestaurantCard.fromModel(item);
        },
        itemCount: restaurant.data.length,
      ),
    );
  }
}

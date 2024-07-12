import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(restaurantProvider);
    if (item is PaginationLoadingModel) {
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

    final restaurant = item as PaginationModel;
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
            height: 22.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final item = restaurant.data[index];
          return GestureDetector(
              onTap: () {
                final detailItem = ref.read(restaurantDetailProvider(item.id));
                context.goNamed(
                  RestaurantDetailScreen.routeName,
                  pathParameters: {
                    'id': detailItem.id,
                  },
                );
              },
              child: RestaurantCard.fromModel(item));
        },
        itemCount: restaurant.data.length,
      ),
    );
  }
}

import 'package:delivery_app/common/component/pagination_view.dart';
import 'package:delivery_app/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PaginationView<RestaurantItem>(
        provider: restaurantProvider,
        builder:<RestaurantItem>(_, index, item) {
          return GestureDetector(
              onTap: () {
                context.goNamed(
                  RestaurantDetailScreen.routeName,
                  pathParameters: {
                    'id': item.id,
                  },
                );
              },
              child: RestaurantCard.fromModel(item));
        });
  }
}

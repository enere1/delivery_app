import 'package:delivery_app/common/component/pagination_view.dart';
import 'package:delivery_app/product/component/product_card.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:delivery_app/product/provider/product_provider.dart';
import 'package:delivery_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatelessWidget {

  static String get routeName => 'Product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationView<ProductItem>(
      provider: productProvider,
      builder: <ProductItem>(_, index, item) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {
                'id': item.restaurant.id,
              },
            );
          },
          child: ProductCard.fromProductItem(item),
        );
      },
    );
  }
}

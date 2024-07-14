import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/product/component/product_card.dart';
import 'package:delivery_app/rating/component/rating_card.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:delivery_app/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/restaurant/provider/restaurant_rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'RestaurantDetail';
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getRestaurantDetail(id: widget.id);
    controller.addListener(isLastItem);
  }

  void isLastItem() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref
          .read(restaurantRatingProvider(widget.id).notifier)
          .paginate(fetchMore: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(isLastItem);
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetItem = ref.watch(restaurantDetailProvider(widget.id));
    final ratingModel = ref.watch(restaurantRatingProvider(widget.id));

    if (targetItem == null) {
      return DefaultLayout(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultLayout(
        appBar: AppBar(
          title: Text(
            targetItem.name,
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(controller: controller, slivers: [
            SliverToBoxAdapter(
              child: RestaurantCard.fromModel(
                targetItem,
                isDetail: targetItem is RestaurantDetailModel ? true : false,
              ),
            ),
            if (targetItem is RestaurantDetailModel) _RenderLabel(),
            if (targetItem is RestaurantDetailModel)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = targetItem.products[index];
                    return Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: ProductCard.fromProductItem(product));
                  },
                  childCount: targetItem.products.length,
                ),
              ),
            if (ratingModel is PaginationModel)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == ratingModel.data.length) {
                      return ratingModel.meta.hasMore
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(child: Text('nomore'));
                    }
                    final ratingItem = ratingModel.data[index] as RatingItem;
                    return Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: RatingCard.fromModel(ratingItem));
                  },
                  childCount: ratingModel.data.length + 1,
                ),
              ),
          ]),
        ));
  }
}

SliverToBoxAdapter _RenderLabel() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        '메뉴',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

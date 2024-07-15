import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/product/component/product_card.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:delivery_app/rating/component/rating_card.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:delivery_app/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/restaurant/provider/restaurant_rating_provider.dart';
import 'package:delivery_app/restaurant/view/basket_screen.dart';
import 'package:delivery_app/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final basketProductNum = ref.watch(basketProvider).length;

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
          if (targetItem is RestaurantDetailModel) _RenderLabel(label: 'メニュー'),
          if (targetItem is RestaurantDetailModel)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = targetItem.products[index];
                  return Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: InkWell(
                          onTap: () async {
                            await ref
                                .read(basketProvider.notifier)
                                .addItem(product);
                          },
                          child: ProductCard.fromProductItem(product)));
                },
                childCount: targetItem.products.length,
              ),
            ),
          if (ratingModel is PaginationModel) _RenderLabel(label: '口コミ'),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(BasketScreen.routeName);
        },
        child: Badge(
          label: Text(basketProductNum.toString()),
          child: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }
}

SliverToBoxAdapter _RenderLabel({required String label}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

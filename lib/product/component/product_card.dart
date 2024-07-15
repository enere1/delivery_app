import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:delivery_app/user/model/basket_model.dart';
import 'package:delivery_app/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  final int? count;
  final String? totalPrice;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  const ProductCard({
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    this.count,
    this.totalPrice,
    this.onSubtract,
    this.onAdd,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromProductItem(
    ProductItem model,
  ) {
    return ProductCard(
      name: model.name,
      detail: model.detail,
      imgUrl: model.imgUrl,
      price: model.price,
    );
  }

  factory ProductCard.fromBasketModel({
    required BasketModel model,
    required VoidCallback onSubtract,
    required VoidCallback onAdd,
  }) {
    return ProductCard(
      name: model.product.name,
      detail: model.product.detail,
      imgUrl: model.product.imgUrl,
      price: model.product.price,
      totalPrice: (model.count * model.product.price).toString(),
      count: model.count,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    height: 110,
                    width: 110,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          )),
                      Text(
                        detail,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '¥${price.toString()}',
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (onSubtract != null && onAdd != null)
              _Footer(
                count: count!,
                total: totalPrice!,
                onAdd: onAdd!,
                onSubtract: onSubtract!,
              ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer({
    super.key,
    required this.count,
    required this.total,
    required this.onAdd,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ¥${total}',
            style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            renderButton(icon: Icons.remove, onTap: onSubtract),
            SizedBox(
              width: 8.0,
            ),
            Text(
              count.toString(),
              style:
                  TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 8.0,
            ),
            renderButton(icon: Icons.add, onTap: onAdd),
          ],
        )
      ],
    );
  }

  Widget renderButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: PRIMARY_COLOR, width: 1.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: PRIMARY_COLOR),
      ),
    );
  }
}

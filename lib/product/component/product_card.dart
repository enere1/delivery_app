import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  const ProductCard({
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromProductModel(ProductModel model) {
    return ProductCard(
        name: model.name,
        detail: model.detail,
        imgUrl: model.imgUrl,
        price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Row(
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
            )
          ],
        ),
      ),
    );
  }
}

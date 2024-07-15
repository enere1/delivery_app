import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/order/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productDetail;
  final int price;

  const OrderCard(
      {required this.orderDate,
      required this.image,
      required this.name,
      required this.productDetail,
      required this.price,
      Key? key})
      : super(key: key);

  factory OrderCard.fromModel({required OrderModel model}) {
    final productDetail = model.products.length < 2
        ? model.products.first.product.name
        : '${model.products.first.product.name} 等 ${model.products.length - 1}個';

    return OrderCard(
        orderDate: model.createdAt,
        image: Image.network(
          model.restaurant.thumbUrl,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        name: model.restaurant.name,
        productDetail: productDetail,
        price: model.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 注文完了'),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: image,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: BODY_TEXT_COLOR,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$productDetail ¥$price',
                    style: TextStyle(
                        color: BODY_TEXT_COLOR, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

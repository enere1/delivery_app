import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final String priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  const RestaurantCard(
      {required this.name,
      required this.thumbUrl,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryFee,
      required this.deliveryTime,
      Key? key})
      : super(key: key);

  factory RestaurantCard.fromModel(RestaurantItem model) {
    return RestaurantCard(
        name: model.name,
        thumbUrl: model.thumbUrl,
        tags: model.tags,
        priceRange: model.priceRange,
        ratings: model.ratings,
        ratingsCount: model.ratingsCount,
        deliveryFee: model.deliveryFee,
        deliveryTime: model.deliveryTime);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(thumbUrl),
            borderRadius: BorderRadius.circular(16.0),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            tags.join('・'),
            style: TextStyle(
              color: BODY_TEXT_COLOR,
            ),
          ),
          Row(
            children: [
              _RenderRating(
                icon: Icons.star,
                label: ratings.toString(),
              ),
              _RenderDot(),
              _RenderRating(
                icon: Icons.receipt,
                label: ratingsCount.toString(),
              ),
              _RenderDot(),
              _RenderRating(
                icon: Icons.timelapse,
                label: deliveryTime.toString(),
              ),
              _RenderDot(),
              _RenderRating(
                icon: Icons.monetization_on,
                label: deliveryFee.toString(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _RenderRating extends StatelessWidget {
  final IconData icon;
  final String label;

  const _RenderRating({required this.icon, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 16.0,
        ),
        SizedBox(width: 4.0),
        Text(label),
      ],
    );
  }
}

class _RenderDot extends StatelessWidget {
  const _RenderDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text('・'),
    );
  }
}

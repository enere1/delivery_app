import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/rating/model/rating_model.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  final List<String> imgUrls;
  final UserModel user;
  final String content;
  final int rating;

  const RatingCard({
    required this.imgUrls,
    required this.user,
    required this.content,
    required this.rating,
    Key? key,
  }) : super(key: key);

  factory RatingCard.fromModel(RatingItem model) => RatingCard(
        imgUrls: model.imgUrls,
        user: model.user,
        content: model.content,
        rating: model.rating,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12.0,
                backgroundImage: Image.asset(
                  'asset/img/logo/codefactory_logo.png',
                ).image,
              ),
              SizedBox(
                width: 11.0,
              ),
              Expanded(
                child: Text(
                  user.username,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      rating,
                      (int number) => Icon(
                            Icons.star,
                            color: PRIMARY_COLOR,
                          )),
                ],
              )
            ],
          ),
          Text(
            content,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          if (imgUrls.length > 0)
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: imgUrls
                      .mapIndexed(
                        (index, e) => Padding(
                          padding: EdgeInsets.only(
                              right: index == imgUrls.length - 1 ? 0 : 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              e,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 8.0)
        ],
      ),
    );
  }
}

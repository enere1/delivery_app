import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static String get routeName => 'Splash';

  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/img/logo/logo.png',
                width: 400,
                height: 100,
              ),
            ],
          ),
        )
    );
  }
}

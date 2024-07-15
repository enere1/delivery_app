import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => '/orderDone';

  const OrderDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.thumb_up_alt_outlined,
          color: PRIMARY_COLOR,
          size: 50.0,
        ),
        const SizedBox(
          height: 32.0,
        ),
        Text(
          'お支払いを完了しました。',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32.0,
        ),
        ElevatedButton(
            onPressed: () {
              context.goNamed(RootTab.routeName);
            },
            child: Text('ホームへ'))
      ],
    ));
  }
}

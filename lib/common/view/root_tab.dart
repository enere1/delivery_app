import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/product/view/product_screen.dart';
import 'package:delivery_app/restaurant/view/restaurant_screen.dart';
import 'package:delivery_app/user/view/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'RootTab';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        title: const Text('デリバリー'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _index = index;
          });
          _tabController.animateTo(
              _index);
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        currentIndex: _index, // 인덱스는 위에서 정의하였음
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'メニュー',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'オーダー履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'プロフィル',
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          Text('hi'),
          Text('hi'),
        ],
      ),
    );
  }
}

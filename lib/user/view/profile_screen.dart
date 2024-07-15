import 'package:delivery_app/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  static String get routeName => 'Profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await ref.read(userProvider.notifier).logout();
        },
        child: Text('ログアウト'),
      ),
    );
  }
}
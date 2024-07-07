import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/user/view/login.dart';
import 'package:delivery_app/user/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Notosans',
          ),
          home: RootTab()),
    ),
  );
}

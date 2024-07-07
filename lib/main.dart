import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/user/view/login.dart';
import 'package:delivery_app/user/view/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(
          fontFamily: 'Notosans',
        ),
        home: RootTab()
    )
  );
}

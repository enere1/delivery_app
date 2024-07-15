import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    this.appBar,
    this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      );
  }
}

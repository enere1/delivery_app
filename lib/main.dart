import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/provider/go_route_provider.dart';
import 'package:delivery_app/common/secureStorage/secure_storage.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/user/view/login.dart';
import 'package:delivery_app/user/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: _APP(),
    ),
  );
}

class _APP extends ConsumerWidget {
  const _APP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouteProvider);
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Notosans',
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}


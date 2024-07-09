import 'package:delivery_app/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouteProvider = StateProvider<GoRouter>((ref){

  final provider = ref.read(authProvider);

  return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirect,
  );
});
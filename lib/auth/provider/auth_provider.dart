import 'package:delivery_app/auth/repository/auth_repository.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/secureStorage/secure_storage.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/product/view/product_screen.dart';
import 'package:delivery_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:delivery_app/user/provider/user_provider.dart';
import 'package:delivery_app/user/view/login.dart';
import 'package:delivery_app/user/view/splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier(ref: ref);
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  // ステートが変わったらお知らせする
  AuthNotifier({required this.ref}) {
    ref.listen<UserBaseModel?>(userProvider, (prev, next) {
      if (prev != next) {
        notifyListeners();
      }
    });
  }

  //goRouter作り
  List<GoRoute> get routes => [
        GoRoute(
            path: '/',
            name: RootTab.routeName,
            builder: (_, __) => const RootTab(),
            routes: [
              GoRoute(
                path: 'restaurant/:id',
                name: RestaurantDetailScreen.routeName,
                builder: (context, state) => RestaurantDetailScreen(
                  id: state.pathParameters['id']!,
                ),
              )
            ]),
        GoRoute(
          path: '/splash',
          name: Splash.routeName,
          builder: (_, __) => const Splash(),
        ),
        GoRoute(
          path: '/login',
          name: Login.routeName,
          builder: (_, __) => const Login(),
        ),
      ];

  // リダイレクト
  String? redirect(BuildContext context, GoRouterState state) {
    final userModel = ref.read(userProvider);
    final isLoginPage = state.location == '/login';
    print('isLoginPage: $isLoginPage state.location: ${state.location}');

    if (userModel == null) {
      return isLoginPage ? null : '/login';
    }

    if (userModel is UserModel) {
      return isLoginPage || state.location == '/splash' ? '/' : null;
    }

    if (userModel is UserErrorModel) {
      return !isLoginPage ? '/login' : null;
    }

    return null;
  }

  Future<void> getNewAccessToken() async {
    print('getNewAccessToken');

    final secureStorage = ref.read(secureStorageProvider);
    final accessToken = await secureStorage.read(key: ACCESS_TOKEN);
    final refreshToken = await secureStorage.read(key: REFRESH_TOKEN);

    if (accessToken == null || refreshToken == null) {
      return;
    }

    final repository = ref.read(authRepositoryProvider);
    final tokenModel = await repository.getNewAccessToken();

    await secureStorage.write(key: ACCESS_TOKEN, value: tokenModel.accessToken);
  }

  Future<void> logout() async {
    await ref.read(userProvider.notifier).logout();
  }
}

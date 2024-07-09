import 'package:delivery_app/auth/provider/auth_provider.dart';
import 'package:delivery_app/auth/repository/auth_repository.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/secureStorage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = StateProvider<Dio>((
  ref,
) {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.headers['accessToken'] == true) {
          options.headers.remove('accessToken');
          final secureStorage = ref.read(secureStorageProvider);
          final accessToken = await secureStorage.read(key: ACCESS_TOKEN);
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        if (options.headers['refreshToken'] == true) {
          options.headers.remove('refreshToken');
          final secureStorage = ref.read(secureStorageProvider);
          final accessToken = await secureStorage.read(key: REFRESH_TOKEN);
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('RES: ${response.requestOptions.uri}, '
            'method: ${response.requestOptions.method},'
            'statusCode: ${response.statusCode}');

        return handler.next(response);
      },
      onError: (error, handler) async {

        if (error.response?.statusCode == 401) {
          ref.read(authProvider.notifier).getNewAccessToken();
          final accessToken = ref.read(secureStorageProvider)..read(key: ACCESS_TOKEN);
          error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
          final retryRes = await dio.fetch(error.requestOptions);
          return handler.resolve(retryRes);
        }

        print('error: ${error.message}');
        return handler.reject(error);
      },
    ),
  );

  return dio;
});

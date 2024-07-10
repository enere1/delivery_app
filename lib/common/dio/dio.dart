import 'package:delivery_app/auth/provider/auth_provider.dart';
import 'package:delivery_app/auth/repository/auth_repository.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/secureStorage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = StateProvider<Dio>((ref,) {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        print(
            'REQ: URL:${options.uri} MESSAGE:${options.method} headers:${options
                .headers}');

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
        print('ERROR: URL:${error.requestOptions.uri} MESSAGE:${error
            .message}  ');

        if (error.response?.statusCode == 401) {
          await ref.read(authProvider.notifier).getNewAccessToken();
          final provider = await ref.read(secureStorageProvider);
          final accessToken = await provider.read(key: ACCESS_TOKEN);
          error.requestOptions.headers['accessToken'] = true;
          final retryRes = await dio.fetch(error.requestOptions);
          return handler.resolve(retryRes);
        }

        return handler.reject(error);
      },
    ),
  );

  return dio;
});

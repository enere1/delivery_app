import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = StateProvider<Dio>((ref, ){

  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzIwMzYwNzE3LCJleHAiOjE3MjAzNjEwMTd9.oKUUMgi72rIc8rzD8GnX5Vp0Eaeg3mJqGU0XfhAq1go';
      return handler.next(options);
    },
  ));
  dio.interceptors.add(LogInterceptor());


  return dio;
});



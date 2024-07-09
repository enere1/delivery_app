import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'user_repository.g.dart';

final userRepositoryProvider = StateProvider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: '$DOMAIN/user');
});

@RestApi()
abstract class UserRepository {

  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/me')
  @Headers({
    'accessToken': true
  })
  Future<UserModel> getMe();

}
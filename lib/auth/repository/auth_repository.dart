import 'package:delivery_app/auth/model/login_model.dart';
import 'package:delivery_app/auth/model/token_model.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart' hide Headers;

part 'auth_repository.g.dart';

final authRepositoryProvider = StateProvider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final authRepository = AuthRepository(dio, baseUrl: '$DOMAIN/auth');
  return authRepository;
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @POST('/login')
  Future<LoginModel> login(@Header('Authorization') String auth);

  @POST('/token')
  @Headers({
    'refreshToken': true
  })
  Future<TokenModel> getNewAccessToken();

}

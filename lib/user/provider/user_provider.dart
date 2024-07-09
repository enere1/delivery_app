import 'package:delivery_app/auth/repository/auth_repository.dart';
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/secureStorage/secure_storage.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:delivery_app/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserBaseModel?>((ref) {
  final authRespository = ref.watch(authRepositoryProvider);
  final userRespository = ref.watch(userRepositoryProvider);
  final secureRespository = ref.read(secureStorageProvider);

  return UserNotifier(
      authRepository: authRespository,
      userRepository: userRespository,
      secureStorage: secureRespository
  );
});

class UserNotifier extends StateNotifier<UserBaseModel?> {

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final FlutterSecureStorage secureStorage;

  UserNotifier({
    required this.authRepository,
    required this.userRepository,
    required this.secureStorage,
  }) : super(UserLoadingModel()){
    getMe();
  }

  Future<void> getMe() async {

    final accessToken = await secureStorage.read(key: ACCESS_TOKEN);
    final refreshToken = await secureStorage.read(key: REFRESH_TOKEN);
    if (accessToken == null || refreshToken == null) {
      state = null;
      return;
    }

    state = await userRepository.getMe();
  }


  Future<void> login({
    required String id,
    required String password,
  }) async {
    final encoredStr = DataUtils.toBasic64('$id:$password');
    final loginModel = await authRepository.login('Basic $encoredStr');

    await secureStorage.write(key: ACCESS_TOKEN, value: loginModel.accessToken);
    await secureStorage.write(
        key: REFRESH_TOKEN, value: loginModel.refreshToken);

    final user = await userRepository.getMe();
    state = user;
  }
}

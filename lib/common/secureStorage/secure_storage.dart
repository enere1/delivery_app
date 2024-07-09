import 'package:riverpod/riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = StateProvider<FlutterSecureStorage>((ref){

  const storage = FlutterSecureStorage();
  return storage;
});
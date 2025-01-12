import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}

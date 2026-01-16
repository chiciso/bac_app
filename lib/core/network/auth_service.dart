import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Use SecureStorage for tokens, NOT SharedPreferences
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    // Mocking an API delay
    await Future.delayed(const Duration(seconds: 2));

    if (email == "user@test.com" && password == "password123") {
      await _storage.write(key: 'auth_token', value: 'fake_jwt_token_123');
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    String? token = await _storage.read(key: 'auth_token');
    return token != null;
  }
}
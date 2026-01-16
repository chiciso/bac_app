import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated }

final currentUserProvider = StateProvider<UserModel?>((ref) => null);

class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(AuthStatus.initial) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = AuthStatus.loading;
    final token = await _storage.read(key: 'auth_token');

    if (token != null) {
      _ref.read(currentUserProvider.notifier).state = UserModel(
        id: "user_001",
        firstName: "Ahmed",
        lastName: "Ben Ali",
        email: "ahmed@example.com",
        phone: "+216 22 000 000",
        section: "Sciences Expérimentales",
        points: 1250,
      );
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthStatus.loading;
    await Future.delayed(const Duration(seconds: 2));

    await _storage.write(key: 'auth_token', value: 'mock_token');
    
    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_001",
      firstName: "Ahmed",
      lastName: "Ben Ali",
      email: email,
      phone: "+216 22 000 000",
      section: "Sciences Expérimentales",
      points: 1250,
    );

    state = AuthStatus.authenticated;
  }

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String section,
  }) async {
    state = AuthStatus.loading;
    await Future.delayed(const Duration(seconds: 2));

    await _storage.write(key: 'auth_token', value: 'mock_token');

    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_new",
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      section: section,
      points: 0,
    );

    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _ref.read(currentUserProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});
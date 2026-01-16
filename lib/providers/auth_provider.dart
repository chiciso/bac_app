import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

/// 1. Auth States
/// Defines the various stages of the authentication lifecycle.
enum AuthStatus { initial, loading, authenticated, unauthenticated }

/// 2. Current User Provider
/// A simple StateProvider that stores the currently logged-in UserModel.
/// It is set to null when no user is logged in.
final currentUserProvider = StateProvider<UserModel?>((ref) => null);

/// 3. Auth Notifier
/// Contains the logic for login, registration, and session management.
class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(AuthStatus.initial) {
    checkAuthStatus();
  }

  /// Checks if a token exists in secure storage when the app launches.
  Future<void> checkAuthStatus() async {
    state = AuthStatus.loading;
    final token = await _storage.read(key: 'auth_token');

    if (token != null) {
      // Mocking a fetch of user data
      _ref.read(currentUserProvider.notifier).state = UserModel(
        id: "user_001",
        firstName: "Ahmed",
        lastName: "Ben Ali",
        email: "ahmed.ba@email.com",
        phone: "+216 22 123 456",
        section: "Sciences Expérimentales",
        points: 1250,
      );
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  /// Logic for logging in a user.
  Future<void> login(String email, String password) async {
    state = AuthStatus.loading;

    // Simulation: Replace this with your actual API call later.
    await Future.delayed(const Duration(seconds: 2));

    await _storage.write(key: 'auth_token', value: 'mock_jwt_token_12345');
    
    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_001",
      firstName: "Ahmed",
      lastName: "Ben Ali",
      email: email,
      phone: "+216 22 123 456",
      section: "Sciences Expérimentales",
      points: 1250,
    );

    state = AuthStatus.authenticated;
  }

  /// Logic for registering a new user.
  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String section,
  }) async {
    state = AuthStatus.loading;

    // Simulation: Replace this with your actual API call later.
    await Future.delayed(const Duration(seconds: 2));

    await _storage.write(key: 'auth_token', value: 'mock_jwt_token_12345');

    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_new",
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      section: section,
      points: 0, // New users start with 0 points
    );

    state = AuthStatus.authenticated;
  }

  /// Logic for logging out.
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _ref.read(currentUserProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }
}

/// 4. The Global Auth Provider
/// This is what you will listen to in your UI.
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});
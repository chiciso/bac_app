import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

// State for current user
final currentUserProvider = StateProvider<UserModel?>((ref) => null);

// State for error messages
final authErrorProvider = StateProvider<String?>((ref) => null);

class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(AuthStatus.initial) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = AuthStatus.loading;
    
    try {
      final token = await _storage.read(key: 'auth_token');
      final userJson = await _storage.read(key: 'user_data');

      if (token != null && userJson != null) {
        // In production, validate token with backend
        // For now, we'll load the stored user
        _ref.read(currentUserProvider.notifier).state = UserModel(
          id: "user_001",
          firstName: "Ahmed",
          lastName: "Ben Ali",
          email: "ahmed@example.com",
          phone: "+216 22 000 000",
          section: "Sciences Expérimentales",
          points: 1250,
          createdAt: DateTime.now(),
        );
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = 'Failed to check auth status';
      state = AuthStatus.unauthenticated;
    }
  }

  Future<bool> login(String email, String password) async {
    state = AuthStatus.loading;
    _ref.read(authErrorProvider.notifier).state = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Simulate successful login
      await _storage.write(key: 'auth_token', value: 'mock_token_${DateTime.now().millisecondsSinceEpoch}');
      
      final user = UserModel(
        id: "user_001",
        firstName: "Ahmed",
        lastName: "Ben Ali",
        email: email,
        phone: "+216 22 000 000",
        section: "Sciences Expérimentales",
        points: 1250,
        createdAt: DateTime.now(),
      );

      await _storage.write(key: 'user_data', value: user.toJson().toString());
      _ref.read(currentUserProvider.notifier).state = user;

      state = AuthStatus.authenticated;
      return true;
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString().replaceAll('Exception: ', '');
      state = AuthStatus.error;
      
      // Return to unauthenticated after showing error
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) state = AuthStatus.unauthenticated;
      });
      
      return false;
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String section,
  }) async {
    state = AuthStatus.loading;
    _ref.read(authErrorProvider.notifier).state = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Validation
      if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || 
          phone.isEmpty || password.isEmpty) {
        throw Exception('All fields are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      if (!email.contains('@')) {
        throw Exception('Invalid email format');
      }

      // Simulate successful registration
      await _storage.write(key: 'auth_token', value: 'mock_token_${DateTime.now().millisecondsSinceEpoch}');

      final user = UserModel(
        id: "user_${DateTime.now().millisecondsSinceEpoch}",
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        section: section,
        points: 0,
        createdAt: DateTime.now(),
      );

      await _storage.write(key: 'user_data', value: user.toJson().toString());
      _ref.read(currentUserProvider.notifier).state = user;

      state = AuthStatus.authenticated;
      return true;
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString().replaceAll('Exception: ', '');
      state = AuthStatus.error;
      
      // Return to unauthenticated after showing error
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) state = AuthStatus.unauthenticated;
      });
      
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_data');
    _ref.read(currentUserProvider.notifier).state = null;
    _ref.read(authErrorProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }

  Future<void> updatePoints(int points) async {
    final currentUser = _ref.read(currentUserProvider);
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(points: points);
      _ref.read(currentUserProvider.notifier).state = updatedUser;
      await _storage.write(key: 'user_data', value: updatedUser.toJson().toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/user_model.dart';
import '../../../core/constants/bac_sections.dart';

/// 1. Auth States
enum AuthStatus { initial, loading, authenticated, unauthenticated }

/// 2. Current User Provider
/// This holds the [UserModel] (FirstName, LastName, Points, Section)
/// It is globally accessible so the Home Page knows which subjects to show.
final currentUserProvider = StateProvider<UserModel?>((ref) => null);

/// 3. Auth Notifier
/// Handles the logic for Login, Logout, and Checking Session on startup.
class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(AuthStatus.initial) {
    checkAuthStatus();
  }

  /// Check if a user is already logged in when the app starts
  Future<void> checkAuthStatus() async {
    state = AuthStatus.loading;
    final token = await _storage.read(key: 'auth_token');

    if (token != null) {
      // Simulation: Fetching user data from local storage or API
      // In a real app, you'd fetch this via the token.
      _ref.read(currentUserProvider.notifier).state = UserModel(
        id: "user_001",
        firstName: "Ahmed",
        lastName: "Ben Ali",
        phoneNumber: "+216 22 123 456",
        section: BacSections.science, // Default mock section
        totalPoints: 1250,
        subjectProgress: {
          "math": 0.45,
          "physic": 0.20,
        },
      );
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  /// Login Logic
  Future<void> login(String email, String password) async {
    state = AuthStatus.loading;

    // Simulate Network Delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock Login Success
    await _storage.write(key: 'auth_token', value: 'mock_jwt_token_12345');
    
    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_001",
      firstName: "Ahmed",
      lastName: "Ben Ali",
      phoneNumber: "+216 22 123 456",
      section: BacSections.science,
      totalPoints: 1250,
      subjectProgress: {"math": 0.10},
    );

    state = AuthStatus.authenticated;
  }

  /// Registration Logic (Connects UI data to the state)
  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String section,
  }) async {
    state = AuthStatus.loading;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    await _storage.write(key: 'auth_token', value: 'mock_jwt_token_12345');

    _ref.read(currentUserProvider.notifier).state = UserModel(
      id: "user_new",
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phone,
      section: section,
      totalPoints: 0, // New users start at 0
      subjectProgress: {},
    );

    state = AuthStatus.authenticated;
  }

  /// Logout Logic
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _ref.read(currentUserProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }
}

/// 4. The Global Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});
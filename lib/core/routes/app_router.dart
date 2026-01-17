import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/auth/register_page.dart';
import '../../pages/home_page.dart';
import '../../pages/profile_page.dart';
import '../../providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation == '/login' || 
                          state.matchedLocation == '/register';
      final isAuthenticated = authStatus == AuthStatus.authenticated;

      // If authenticated and trying to access auth pages, redirect to home
      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      // If not authenticated and trying to access protected pages, redirect to login
      if (!isAuthenticated && !isAuthRoute && authStatus != AuthStatus.loading) {
        return '/login';
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
});
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/auth/register_page.dart';
import '../../pages/home_page.dart';
import '../../providers/auth_provider.dart';


final routerProvider = Provider<GoRouter>((ref) {
  // Listen to the auth state
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    // REDIRECT LOGIC: This runs every time authState changes
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      // If user is not authenticated and not on auth pages, send them to login
      if (authState == AuthStatus.unauthenticated) {
        return (isLoggingIn || isRegistering) ? null : '/login';
      }

      // If user is authenticated and trying to access login/register, send them home
      if (authState == AuthStatus.authenticated) {
        if (isLoggingIn || isRegistering) return '/';
      }

      // If still loading, stay where we are
      return null;
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
    ],
  );
});
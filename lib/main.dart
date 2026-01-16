import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'pages/auth/login_page.dart';
import 'pages/main_navigation_page.dart';

void main() {
  // ProviderScope is required for Riverpod to work
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This listens to the authStatus we defined in auth_provider.dart
    final authStatus = ref.watch(authProvider);

    return MaterialApp(
      title: 'Bac App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Here is the logic switch
      home: _getHome(authStatus),
    );
  }

  Widget _getHome(AuthStatus status) {
    switch (status) {
      case AuthStatus.authenticated:
        return const MainNavigationPage();
      case AuthStatus.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthStatus.unauthenticated:
      default:
        return const LoginPage();
    }
  }
}
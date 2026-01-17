import 'package:flutter_riverpod/legacy.dart';

// Navigation State Notifier
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    if (index >= 0 && index <= 2) {
      state = index;
    }
  }

  void goToHome() => state = 0;
  void goToExplore() => state = 1;
  void goToProfile() => state = 2;
}

// Provider for navigation
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});
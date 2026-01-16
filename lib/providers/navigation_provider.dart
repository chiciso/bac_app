import 'package:flutter_riverpod/legacy.dart';

// Keeps track of the active tab (0 = Home, 1 = Search, 2 = Profile)
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) => state = index;
}
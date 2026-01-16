import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../widgets/home_content.dart';
import '../widgets/app_bottom_bar.dart';
import 'profile_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final List<Widget> pages = [
      const HomeContent(),
      const Center(child: Text("Recherche")), // Placeholder for Search
      const ProfilePage(),
    ];

    return Scaffold(
      // ALLOWS GRADIENT TO FLOW UNDER BOTTOM BAR
      extendBody: true, 
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(navigationIndexProvider.notifier).state = index,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:ui';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30), // Floating style
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.white.withValues(alpha: 0.8),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "Explore"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
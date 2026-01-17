import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class CustomBackground extends ConsumerWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This watches the color provider. When the provider changes,
    // the background will rebuild with the new color automatically.
    final accentColor = ref.watch(backgroundAccentColorProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500), // Smooth transition
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor,               // Dynamic Top Color
            accentColor.withOpacity(0.7), // Dynamic Bottom Color
          ],
        ),
      ),
    );
  }
}
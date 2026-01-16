import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// These imports are now fully utilized by the type annotations below
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FIX: Explicit Type Annotation (UserModel?) tells Dart why we need the import
    final UserModel? user = ref.watch(currentUserProvider);

    // Safety check: If the provider is null, show a loading spinner
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(user),
          const SizedBox(height: 20),
          _buildPointsSection(user),
          const SizedBox(height: 30),
          // You can add your Subject Cards or Horizontal List here
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Tes Matières",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // FIX: Explicit Parameter Type (UserModel) ensures the import is used
  Widget _buildHeader(UserModel user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aslama, ${user.firstName} 👋",
            style: const TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.section,
            style: TextStyle(
              fontSize: 16, 
              color: Colors.blueGrey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsSection(UserModel user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ton Score",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                "Niveau Bac",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${user.points} XP",
              style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
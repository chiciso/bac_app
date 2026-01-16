import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In real app: final user = ref.watch(userProvider);
    // Hardcoded for UI demo:
    final String fullName = "Ahmed Ben Ali";
    final String phone = "+216 55 123 456";
    final String section = "Mathématiques";
    final int points = 1250;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          
          // Identity
          Text(fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(phone, style: const TextStyle(color: Colors.grey)),
          
          const SizedBox(height: 24),

          // Stats Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Section", section, Colors.blue),
                _buildStatItem("Points", "$points", Colors.amber),
                _buildStatItem("Rank", "#12", Colors.purple),
              ],
            ),
          ),

          const SizedBox(height: 32),
          
          // Settings Options
          _buildOption(Icons.history, "Exam History", () {}),
          _buildOption(Icons.edit, "Edit Profile", () {}),
          const Divider(),
          _buildOption(Icons.logout, "Logout", () {
             ref.read(authProvider.notifier).logout();
          }, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black87),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : Colors.black87, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
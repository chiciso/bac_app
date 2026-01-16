import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView( // Prevents overflow on the profile page
        child: Column(
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 16),
            Text(
              "${user?.firstName} ${user?.lastName}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? "",
              style: const TextStyle(color: Colors.grey),
            ),
            
            // Stats Card (Points/Rank)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat("Section", user?.section ?? "-"),
                    _buildStat("Points", "1250"),
                    _buildStat("Rang", "#12"),
                  ],
                ),
              ),
            ),

            // Use your profile_menu_item widget here
            _buildMenuItem(Icons.history, "Historique des examens", () {}),
            _buildMenuItem(Icons.edit, "Modifier le profil", () {}),
            const Divider(indent: 20, endIndent: 20),
            _buildMenuItem(Icons.logout, "Se déconnecter", () {
              ref.read(authProvider.notifier).logout();
            }, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_colors.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/app_button.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSpacing.h32,
                      // Avatar
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.primaryLight,
                              child: Text(
                                user.initials,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.verified_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.h16,
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      AppSpacing.h4,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.section,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                AppSpacing.h24,

                // Stats Row
                _buildStatsRow(user),
                AppSpacing.h24,

                // User Info Card
                _buildInfoCard(user),
                AppSpacing.h24,

                // Menu Section
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Compte",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      AppSpacing.h12,
                    ],
                  ),
                ),

                // Menu Items
                ProfileMenuItem(
                  icon: Icons.edit_rounded,
                  title: "Modifier le profil",
                  subtitle: "Mettre à jour vos informations",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h8,
                ProfileMenuItem(
                  icon: Icons.lock_rounded,
                  title: "Changer le mot de passe",
                  subtitle: "Sécuriser votre compte",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h24,

                Padding(
                  padding: AppSpacing.paddingH20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Préférences",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      AppSpacing.h12,
                    ],
                  ),
                ),

                ProfileMenuItem(
                  icon: Icons.notifications_rounded,
                  title: "Notifications",
                  subtitle: "Gérer les alertes",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h8,
                ProfileMenuItem(
                  icon: Icons.language_rounded,
                  title: "Langue",
                  subtitle: "Français",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h8,
                ProfileMenuItem(
                  icon: Icons.dark_mode_rounded,
                  title: "Thème",
                  subtitle: "Clair",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h24,

                Padding(
                  padding: AppSpacing.paddingH20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Support",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      AppSpacing.h12,
                    ],
                  ),
                ),

                ProfileMenuItem(
                  icon: Icons.help_rounded,
                  title: "Aide & FAQ",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h8,
                ProfileMenuItem(
                  icon: Icons.privacy_tip_rounded,
                  title: "Confidentialité",
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                AppSpacing.h8,
                ProfileMenuItem(
                  icon: Icons.info_rounded,
                  title: "À propos",
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                AppSpacing.h32,
                
                // Logout Button
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: AppButton(
                    text: "Se déconnecter",
                    onTap: () => _handleLogout(context, ref),
                    icon: Icons.logout_rounded,
                    color: AppColors.error,
                  ),
                ),
                AppSpacing.h16,

                // Version
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),

                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(user) {
    return Padding(
      padding: AppSpacing.paddingH20,
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              label: "Points",
              value: "${user.points}",
              icon: Icons.stars_rounded,
              color: AppColors.warning,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.grey300,
          ),
          Expanded(
            child: _buildStatItem(
              label: "Rang",
              value: "#12",
              icon: Icons.emoji_events_rounded,
              color: AppColors.primary,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.grey300,
          ),
          Expanded(
            child: _buildStatItem(
              label: "Série",
              value: "7j",
              icon: Icons.local_fire_department_rounded,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        AppSpacing.h8,
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        AppSpacing.h4,
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(user) {
    return Container(
      margin: AppSpacing.paddingH20,
      padding: AppSpacing.padding20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.email_rounded,
            "Email",
            user.email,
            AppColors.primary,
          ),
          const Divider(height: 32),
          _buildInfoRow(
            Icons.phone_rounded,
            "Téléphone",
            user.phone,
            AppColors.success,
          ),
          const Divider(height: 32),
          _buildInfoRow(
            Icons.calendar_today_rounded,
            "Membre depuis",
            user.createdAt != null 
                ? "${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}"
                : "Récent",
            AppColors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        AppSpacing.w16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpacing.h4,
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error),
            AppSpacing.w12,
            const Text("Déconnexion"),
          ],
        ),
        content: const Text(
          "Êtes-vous sûr de vouloir vous déconnecter?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Annuler",
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Déconnexion"),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Bac App',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.school_rounded,
          size: 40,
          color: AppColors.primary,
        ),
      ),
      children: [
        const Text(
          'Application de préparation au Baccalauréat tunisien.\n\n'
          'Développé avec ❤️ pour les étudiants.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_rounded, color: Colors.white),
            AppSpacing.w12,
            const Text('Fonctionnalité à venir'),
          ],
        ),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/user_model.dart';
import '../models/subject.dart';
import '../providers/auth_provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/subject_card.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/app_shimmer.dart';

// Mock subjects provider
final subjectsProvider = StateProvider<List<Subject>>((ref) {
  return [
    Subject(
      id: '1',
      title: 'Mathématiques',
      imageUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800',
      color: Colors.blue,
      targetSections: ['Mathématiques', 'Sciences Expérimentales'],
      availableYears: [2024, 2023, 2022, 2021, 2020],
    ),
    Subject(
      id: '2',
      title: 'Physique',
      imageUrl: 'https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?w=800',
      color: Colors.purple,
      targetSections: ['Sciences Expérimentales', 'Mathématiques'],
      availableYears: [2024, 2023, 2022, 2021],
    ),
    Subject(
      id: '3',
      title: 'Sciences SVT',
      imageUrl: 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800',
      color: Colors.green,
      targetSections: ['Sciences Expérimentales'],
      availableYears: [2024, 2023, 2022],
    ),
    Subject(
      id: '4',
      title: 'Français',
      imageUrl: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800',
      color: Colors.orange,
      targetSections: ['Toutes sections'],
      availableYears: [2024, 2023, 2022, 2021],
    ),
    Subject(
      id: '5',
      title: 'Philosophie',
      imageUrl: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800',
      color: Colors.pink,
      targetSections: ['Toutes sections'],
      availableYears: [2024, 2023, 2022],
    ),
  ];
});

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(currentUserProvider);
    final subjects = ref.watch(subjectsProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Gradient App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: AppSpacing.paddingH20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Aslama, ${user.firstName} 👋",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  AppSpacing.h4,
                                  Text(
                                    user.section,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Profile Avatar
                            GestureDetector(
                              onTap: () => context.go('/profile'),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Text(
                                  user.initials,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h16,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.h20,
                
                // Points Card
                _buildPointsCard(user),
                AppSpacing.h32,

                // Quick Stats
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: const Text(
                    "Tes Statistiques",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSpacing.h16,
                _buildQuickStats(),
                AppSpacing.h32,

                // Progress Section
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: const Text(
                    "Ton Progrès",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSpacing.h16,
                _buildProgressSection(),
                AppSpacing.h32,

                // Subjects Section
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tes Matières",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to all subjects
                        },
                        child: const Text("Voir tout"),
                      ),
                    ],
                  ),
                ),
                AppSpacing.h8,
                _buildSubjectCards(subjects),
                AppSpacing.h32,

                // Recent Activity
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: const Text(
                    "Activité Récente",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSpacing.h16,
                _buildRecentActivity(),
                
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard(UserModel user) {
    return Container(
      margin: AppSpacing.paddingH20,
      padding: AppSpacing.padding24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ton Score Total",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpacing.h8,
                const Text(
                  "Niveau Baccalauréat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.h4,
                const Text(
                  "Continue comme ça! 🎯",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "${user.points}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const Text(
                  "XP",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: AppSpacing.paddingH20,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.assignment_turned_in_rounded,
              label: "Exercices",
              value: "24",
              subtitle: "complétés",
              color: AppColors.success,
            ),
          ),
          AppSpacing.w12,
          Expanded(
            child: _buildStatCard(
              icon: Icons.local_fire_department_rounded,
              label: "Série",
              value: "7j",
              subtitle: "d'affilée",
              color: AppColors.warning,
            ),
          ),
          AppSpacing.w12,
          Expanded(
            child: _buildStatCard(
              icon: Icons.emoji_events_rounded,
              label: "Rang",
              value: "#12",
              subtitle: "national",
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          AppSpacing.h12,
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.h4,
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: AppSpacing.paddingH20,
      child: Container(
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
            AppProgressIndicator(
              progress: 0.75,
              label: "Mathématiques",
              color: Colors.blue,
            ),
            AppSpacing.h16,
            AppProgressIndicator(
              progress: 0.60,
              label: "Physique",
              color: Colors.purple,
            ),
            AppSpacing.h16,
            AppProgressIndicator(
              progress: 0.45,
              label: "Sciences SVT",
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCards(List<Subject> subjects) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final progress = 0.3 + (index * 0.15); // Mock progress
          
          return SizedBox(
            width: 280,
            child: SubjectCard(
              subject: subject,
              progress: progress.clamp(0.0, 1.0),
              onTap: () {
                // Navigate to subject detail
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      {
        'icon': Icons.check_circle_rounded,
        'color': AppColors.success,
        'title': 'Exercice de Mathématiques',
        'subtitle': 'Complété • +50 XP',
        'time': 'Il y a 2h'
      },
      {
        'icon': Icons.star_rounded,
        'color': AppColors.warning,
        'title': 'Nouveau badge débloqué',
        'subtitle': 'Expert en Physique',
        'time': 'Il y a 5h'
      },
      {
        'icon': Icons.assignment_rounded,
        'color': AppColors.info,
        'title': 'Nouveau chapitre disponible',
        'subtitle': 'SVT - Génétique',
        'time': 'Hier'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.paddingH20,
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: AppSpacing.padding16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: activity['color'] as Color,
                  size: 24,
                ),
              ),
              AppSpacing.w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    AppSpacing.h4,
                    Text(
                      activity['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                activity['time'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
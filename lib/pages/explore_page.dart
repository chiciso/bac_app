import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/exercise_tile.dart';
import '../widgets/app_empty_state.dart';
import '../widgets/base_view.dart';
import '../widgets/app_shimmer.dart';

// Mock provider for loading state
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Mock provider for exercises
final exercisesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'title': 'Mathématiques - Analyse',
      'year': '2024',
      'session': 'Principale',
      'isCompleted': true,
    },
    {
      'title': 'Physique - Mécanique',
      'year': '2024',
      'session': 'Principale',
      'isCompleted': false,
    },
    {
      'title': 'Sciences SVT - Génétique',
      'year': '2023',
      'session': 'Contrôle',
      'isCompleted': true,
    },
    {
      'title': 'Mathématiques - Probabilités',
      'year': '2023',
      'session': 'Principale',
      'isCompleted': false,
    },
    {
      'title': 'Français - Dissertation',
      'year': '2024',
      'session': 'Principale',
      'isCompleted': false,
    },
  ];
});

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ref.watch(exercisesProvider);
    final isLoading = ref.watch(isLoadingProvider);

    // Filter exercises based on search
    final filteredExercises = exercises.where((exercise) {
      if (_searchQuery.isEmpty) return true;
      return exercise['title']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return BaseView(
      title: "Recherche & Exercices",
      showBackButton: false,
      body: Column(
        children: [
          // Search Bar Section
          Container(
            padding: AppSpacing.paddingH20,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  AppSpacing.h16,
                  AppSearchBar(
                    hintText: "Rechercher un exercice...",
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onFilterTap: () {
                      _showFilterSheet(context);
                    },
                  ),
                  AppSpacing.h16,
                ],
              ),
            ),
          ),

          // Quick Filter Chips
          Container(
            padding: AppSpacing.paddingV16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: AppSpacing.paddingH20,
              child: Row(
                children: [
                  _buildFilterChip('Tous', true),
                  AppSpacing.w8,
                  _buildFilterChip('Math', false),
                  AppSpacing.w8,
                  _buildFilterChip('Physique', false),
                  AppSpacing.w8,
                  _buildFilterChip('SVT', false),
                  AppSpacing.w8,
                  _buildFilterChip('Français', false),
                ],
              ),
            ),
          ),

          // Exercise List
          Expanded(
            child: isLoading
                ? _buildLoadingState()
                : filteredExercises.isEmpty
                    ? AppEmptyState(
                        icon: Icons.search_off_rounded,
                        title: "Aucun résultat",
                        message: "Essayez de modifier votre recherche",
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        itemCount: filteredExercises.length,
                        itemBuilder: (context, index) {
                          final exercise = filteredExercises[index];
                          return ExerciseTile(
                            title: exercise['title'],
                            year: exercise['year'],
                            session: exercise['session'],
                            isCompleted: exercise['isCompleted'],
                            onTap: () => _openExercise(context, exercise),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
      backgroundColor: AppColors.grey100,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: AppSpacing.paddingH20,
      itemCount: 5,
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterSheet(),
    );
  }

  void _openExercise(BuildContext context, Map<String, dynamic> exercise) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture: ${exercise['title']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
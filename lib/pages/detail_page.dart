import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/exercise_tile.dart';
import '../widgets/app_button.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/app_empty_state.dart';

class DetailPage extends ConsumerStatefulWidget {
  final Subject subject;

  const DetailPage({super.key, required this.subject});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedYear = '2024';
  String _selectedSession = 'Principale';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: widget.subject.color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.subject.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.subject.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: widget.subject.color,
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          widget.subject.color.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.h24,

                // Progress Section
                Padding(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ton Progrès",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSpacing.h16,
                        AppProgressIndicator(
                          progress: 0.65,
                          label: "Exercices complétés",
                          color: widget.subject.color,
                        ),
                        AppSpacing.h16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatChip(
                              "15/23",
                              "Complétés",
                              Icons.check_circle,
                            ),
                            _buildStatChip(
                              "8",
                              "En cours",
                              Icons.pending,
                            ),
                            _buildStatChip(
                              "350",
                              "Points XP",
                              Icons.star,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.h24,

                // Filters
                Padding(
                  padding: AppSpacing.paddingH20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Filtrer par",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.h12,
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              value: _selectedYear,
                              items: widget.subject.availableYears
                                  .map((y) => y.toString())
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedYear = value!;
                                });
                              },
                              icon: Icons.calendar_today,
                            ),
                          ),
                          AppSpacing.w12,
                          Expanded(
                            child: _buildDropdown(
                              value: _selectedSession,
                              items: widget.subject.sessions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedSession = value!;
                                });
                              },
                              icon: Icons.event_note,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.h24,

                // Tab Bar
                Container(
                  margin: AppSpacing.paddingH20,
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: widget.subject.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: "Exercices"),
                      Tab(text: "Corrections"),
                    ],
                  ),
                ),
                AppSpacing.h16,

                // Tab Content
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildExercisesList(),
                      _buildCorrectionsList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: widget.subject.color, size: 28),
        AppSpacing.h8,
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: widget.subject.color),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Row(
              children: [
                Icon(icon, size: 18, color: AppColors.textSecondary),
                AppSpacing.w8,
                Text(item),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildExercisesList() {
    // Mock exercises data
    final exercises = [
      {
        'title': 'Exercice 1 - Analyse',
        'year': _selectedYear,
        'session': _selectedSession,
        'isCompleted': true,
      },
      {
        'title': 'Exercice 2 - Algèbre',
        'year': _selectedYear,
        'session': _selectedSession,
        'isCompleted': true,
      },
      {
        'title': 'Exercice 3 - Géométrie',
        'year': _selectedYear,
        'session': _selectedSession,
        'isCompleted': false,
      },
      {
        'title': 'Exercice 4 - Probabilités',
        'year': _selectedYear,
        'session': _selectedSession,
        'isCompleted': false,
      },
    ];

    if (exercises.isEmpty) {
      return AppEmptyState(
        icon: Icons.assignment_outlined,
        title: "Aucun exercice",
        message: "Aucun exercice disponible pour cette sélection",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return ExerciseTile(
          title: exercise['title'] as String,
          year: exercise['year'] as String,
          session: exercise['session'] as String,
          isCompleted: exercise['isCompleted'] as bool,
          onTap: () {
            _openExercise(exercise);
          },
        );
      },
    );
  }

  Widget _buildCorrectionsList() {
    return AppEmptyState(
      icon: Icons.check_circle_outline,
      title: "Corrections",
      message: "Les corrections seront disponibles après avoir complété l'exercice",
      action: AppButton(
        text: "Commencer un exercice",
        onTap: () {
          _tabController.animateTo(0);
        },
        icon: Icons.play_arrow_rounded,
      ),
    );
  }

  void _openExercise(Map<String, dynamic> exercise) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture: ${exercise['title']}'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: widget.subject.color,
      ),
    );
  }
}
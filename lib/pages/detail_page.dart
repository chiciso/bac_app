import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../models/exercise.dart';
import '../providers/exercise_provider.dart';
import '../widgets/exercise_tile.dart';
import '../widgets/app_network_image.dart';
import 'pdf_viewer_page.dart';

class DetailPage extends ConsumerWidget {
  final Subject subject;

  const DetailPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected session (Principale vs Controle)
    final selectedSession = ref.watch(selectedSessionProvider);
    
    // Watch the exercises (PDFs) available for this subject
    final exercisesAsync = ref.watch(subjectExercisesProvider(subject.id));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Dynamic Header with Subject Image
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            stretch: true,
            backgroundColor: subject.color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                subject.title, // FIXED: Matches your new model
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(imageUrl: subject.imageUrl), // FIXED: Uses 'url' param
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Session Switcher (Principale / Contrôle)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Session d'examen",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<SessionType>(
                      style: SegmentedButton.styleFrom(
                        selectedBackgroundColor: subject.color.withValues(alpha: 0.2),
                        selectedForegroundColor: subject.color,
                      ),
                      segments: const [
                        ButtonSegment(
                          value: SessionType.principale, 
                          label: Text("Principale"),
                          icon: Icon(Icons.star_outline),
                        ),
                        ButtonSegment(
                          value: SessionType.controle, 
                          label: Text("Contrôle"),
                          icon: Icon(Icons.loop),
                        ),
                      ],
                      selected: {selectedSession},
                      onSelectionChanged: (newSelection) {
                        ref.read(selectedSessionProvider.notifier).state = newSelection.first;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Annales disponibles",
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // 3. The Year Grid
          exercisesAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text("Erreur de chargement: $err")),
            ),
            data: (exercises) {
              // Filter exercises based on selected session
              final filtered = exercises.where((e) => e.session == selectedSession).toList();
              
              // Get years from the filtered list and sort descending
              final years = filtered.map((e) => e.year).toSet().toList()
                ..sort((a, b) => b.compareTo(a));

              if (years.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text("Aucun document pour cette session."),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final year = years[index];
                      return ExerciseTile(
                        year: year,
                        isCompleted: false, // Future: Connect to user progress
                        onTap: () {
                          // Filter for the Exam Paper specifically (not correction)
                          final target = filtered.firstWhere(
                            (e) => e.year == year && e.type == DocumentType.exam,
                            orElse: () => filtered.first,
                          );
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PdfViewerPage(exercise: target),
                            ),
                          );
                        },
                      );
                    },
                    childCount: years.length,
                  ),
                ),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
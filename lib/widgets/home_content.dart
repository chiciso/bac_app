import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subject_provider.dart';
import '../providers/auth_provider.dart';
import '../pages/detail_page.dart';
import 'subject_card.dart';
import '../models/user_model.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  late PageController _pageController;
  Color? _activeColor;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(filteredSubjectsProvider);
    final user = ref.watch(currentUserProvider);

    return subjectsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Erreur de chargement")),
      data: (subjects) {
        if (subjects.isEmpty) return const Center(child: Text("Aucune donnée"));
        _activeColor ??= subjects.first.color;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_activeColor!.withValues(alpha: 0.2), Colors.white],
              stops: const [0.0, 0.6],
            ),
          ),
          child: SafeArea(
            bottom: false, // Allows gradient to flow behind Nav Bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(user),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: subjects.length,
                    onPageChanged: (i) => setState(() => _activeColor = subjects[i].color),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SubjectCard(
                          subject: subjects[index],
                          progress: 0.1, // Placeholder
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailPage(subject: subjects[index])),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // FIXED: Smaller spacer to prevent overflow banner seen in video
                const SizedBox(height: 70), 
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Aslama, ${user?.firstName ?? 'Ahmed'}", 
               style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(user?.section ?? "Sciences Expérimentales", 
               style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
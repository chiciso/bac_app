import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subject_provider.dart';
import '../providers/auth_provider.dart';
import '../pages/detail_page.dart';
import 'subject_card.dart';
import 'base_view.dart';

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(filteredSubjectsProvider);
    final user = ref.watch(currentUserProvider);

    return subjectsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => BaseView(state: ViewState.error, onRetry: () => ref.refresh(filteredSubjectsProvider), child: const SizedBox()),
      data: (subjects) {
        if (subjects.isEmpty) return const Center(child: Text("Aucune matière trouvée"));

        _activeColor ??= subjects.first.color;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.decelerate,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _activeColor!.withValues(alpha: 0.2), // The "Glow"
                Colors.white.withValues(alpha: 0.9),
                Colors.white,                   // Base color
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            bottom: false,// Let the gradient flow under the bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 70, 24, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("hey, ${user?.firstName ?? 'Étudiant'}", style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      Text(user?.section ?? "Bac Tunisien", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            
                // Subject Carousel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: subjects.length,
                    clipBehavior: Clip.none,
                    onPageChanged: (index) => setState(() => _activeColor = subjects[index].color),
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SubjectCard(
                          subject: subject,
                          progress: user?.getProgressFor(subject.id) ?? 0.0,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(subject: subject))),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80), // Ensures nothing is hidden by the bar
              ],
            ),
          ),
        );
      },
    );
  }
}
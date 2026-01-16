import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/subject.dart';
import '../providers/auth_provider.dart';
import '../../../core/constants/mock_data.dart';

// 1. Repository Provider (Simulated for now)
final subjectRepositoryProvider = Provider((ref) => SubjectRepository());

// 2. The Main Subjects Provider
final subjectsProvider = FutureProvider<List<Subject>>((ref) async {
  // Wait for the user to be loaded
  final user = ref.watch(currentUserProvider); // Make sure you have a provider exposing the UserModel
  
  if (user == null) {
    // If no user is logged in yet, return empty or default
    return []; 
  }

  // Fetch all subjects
  final repository = ref.watch(subjectRepositoryProvider);
  final allSubjects = await repository.fetchSubjects();

  // FILTER LOGIC: Only show subjects relevant to the user's Bac Section
  // Example: If user is "Economie", they won't see "Technologie"
  final filteredSubjects = allSubjects.where((subject) {
    return subject.targetSections.contains(user.section);
  }).toList();

  return filteredSubjects;
});

class SubjectRepository {
  Future<List<Subject>> fetchSubjects() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.subjects;
  }
}
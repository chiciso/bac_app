import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/mock_data.dart';
import '../../models/subject.dart';

class SubjectRepository {
  // Fetch all subjects from the mock database
  Future<List<Subject>> getSubjects() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In the future, this would be: return api_client.get('/subjects');
    return MockData.subjects; 
  }
}

// Provide the repository globally
final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository();
});
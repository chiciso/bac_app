class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;    // Must exist
  final String phone;    // Must match the name in provider
  final String section;
  final int points;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.section,
    this.points = 0,
  });

  // copyWith is essential for updating user points later
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? section,
    int? points,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      section: section ?? this.section,
      points: points ?? this.points,
    );
  }
}
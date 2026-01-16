class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email; 
  final String phone; // Added field
  final String section;
  final int points;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone, // Added to constructor
    required this.section,
    this.points = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '', // Added to factory
      section: json['section'] ?? '',
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone, // Added to JSON
      'section': section,
      'points': points,
    };
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone, // Added to copyWith
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
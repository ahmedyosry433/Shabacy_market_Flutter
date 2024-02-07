class UserProfile {
  final String name;

  final String email;

  final String role;
  final String updatedAt;
  final String id;

  UserProfile(this.name, this.email, this.role, this.updatedAt, this.id);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      json['name'] ?? '',
      json['email'] ?? '',
      json['role'] ?? '',
      json['updated_at'] ?? '',
      json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'id': id,
    };
  }
}

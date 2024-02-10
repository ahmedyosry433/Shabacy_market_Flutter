class UserModel {
  final String name;
  final String email;
  final String role;
  final String updatedAt;
  final String id;

  UserModel(this.name, this.email, this.role, this.updatedAt, this.id);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
      'updated_at': updatedAt,
      'id': id,
    };
  }
}

class UserModel {
  final String name;
  final String email;
  final String role;
  final String updatedAt;
  final String id;
  final String Password;

  UserModel(this.name, this.email, this.role, this.updatedAt, this.id,this.Password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['name'] ?? '',
      json['email'] ?? '',
      json['role'] ?? '',
      json['updated_at'] ?? '',
      json['id'] ?? '',
      json['password']??'',
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

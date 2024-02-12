class UserModel {
  final String name;
  final String email;
  final String role;

  final String id;
  final String password;

  UserModel(this.name, this.email, this.role, this.id, this.password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['name'] ?? '',
      json['email'] ?? '',
      json['role'] ?? '',
      json['id'] ?? '',
      json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'id': id,
      'password': password,
    };
  }
}

class AddUserModel {
  final String name;
  final String email;
  final String role;
final String mobile;
  final String password;

  AddUserModel(this.name, this.email, this.role, this.password, this.mobile);

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      json['name'] ?? '',
      json['email'] ?? '',
      json['role'] ?? '',
      json['password'] ?? '',
      json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'password': password,
      'mobile': mobile,

    };
  }
}

class EditUserModel {
  final String name;
  final String email;
  final String role;

  final String mobile;

  EditUserModel(this.name, this.email, this.role, this.mobile);

  factory EditUserModel.fromJson(Map<String, dynamic> json) {
    return EditUserModel(
      json['name'] ?? '',
      json['email'] ?? '',
      json['role'] ?? '',
      json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'mobile': mobile,
    };
  }
}

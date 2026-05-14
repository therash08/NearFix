import 'dart:convert';

enum UserRole { user, provider, admin }

UserRole userRoleFromString(String s) {
  switch (s) {
    case 'provider':
      return UserRole.provider;
    case 'admin':
      return UserRole.admin;
    case 'user':
    default:
      return UserRole.user;
  }
}

String userRoleToString(UserRole r) => r.toString().split('.').last;

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'role': userRoleToString(role),
  };

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    password: json['password'] ?? '',
    role: userRoleFromString(json['role'] ?? 'user'),
  );

  String encode() => jsonEncode(toJson());

  static UserModel decode(String s) => UserModel.fromJson(jsonDecode(s));
}

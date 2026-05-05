class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      email: json['email'] ?? 'Sin email',
      role: json['role'] ?? 'customer',
      avatar: json['avatar'] ?? '',
    );
  }
}
enum UserRole { customer, vira, garageAdmin, garageMechanic, mechzoAdmin, mechzoOps }

class User {
  const User({
    required this.id,
    required this.phone,
    required this.role,
    this.name,
    this.email,
    this.avatarUrl,
    this.createdAt,
  });

  final String id;
  final String phone;
  final UserRole role;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> j) => User(
        id: j['id'] as String,
        phone: j['phone'] as String,
        role: UserRole.values.byName(j['role'] as String),
        name: j['name'] as String?,
        email: j['email'] as String?,
        avatarUrl: j['avatarUrl'] as String?,
        createdAt: j['createdAt'] != null
            ? DateTime.parse(j['createdAt'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'role': role.name,
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final List<String> savedAddresses;
  final List<String> favoriteServiceIds;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.savedAddresses,
    required this.favoriteServiceIds,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    List<String>? savedAddresses,
    List<String>? favoriteServiceIds,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      favoriteServiceIds: favoriteServiceIds ?? this.favoriteServiceIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      savedAddresses: List<String>.from(json['savedAddresses'] ?? []),
      favoriteServiceIds: List<String>.from(json['favoriteServiceIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'savedAddresses': savedAddresses,
      'favoriteServiceIds': favoriteServiceIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

typedef User = UserModel;

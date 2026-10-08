class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final String location;
  final String memberTier; // 'Celebration Luxe Member'
  final int eventsHosted;
  final bool biometricsEnabled;
  final bool twoFactorEnabled;
  final bool emailNotifications;
  final bool pushNotifications;
  final String preferredCurrency;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.location,
    this.memberTier = 'Celebration Luxe Member',
    this.eventsHosted = 4,
    this.biometricsEnabled = true,
    this.twoFactorEnabled = false,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.preferredCurrency = 'USD',
  });

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? location,
    String? memberTier,
    int? eventsHosted,
    bool? biometricsEnabled,
    bool? twoFactorEnabled,
    bool? emailNotifications,
    bool? pushNotifications,
    String? preferredCurrency,
  }) {
    return UserProfile(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      location: location ?? this.location,
      memberTier: memberTier ?? this.memberTier,
      eventsHosted: eventsHosted ?? this.eventsHosted,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      preferredCurrency: preferredCurrency ?? this.preferredCurrency,
    );
  }
}

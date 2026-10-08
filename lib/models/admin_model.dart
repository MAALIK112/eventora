class AdminAnalytics {
  final double totalGmv; // Gross Marketplace Volume
  final double activeEscrowHold;
  final double totalCommissionEarned;
  final int totalBookingsCount;
  final int activeVendorsCount;
  final int activeUsersCount;
  final double satisfactionRate;

  const AdminAnalytics({
    required this.totalGmv,
    required this.activeEscrowHold,
    required this.totalCommissionEarned,
    required this.totalBookingsCount,
    required this.activeVendorsCount,
    required this.activeUsersCount,
    required this.satisfactionRate,
  });

  AdminAnalytics copyWith({
    double? totalGmv,
    double? activeEscrowHold,
    double? totalCommissionEarned,
    int? totalBookingsCount,
    int? activeVendorsCount,
    int? activeUsersCount,
    double? satisfactionRate,
  }) {
    return AdminAnalytics(
      totalGmv: totalGmv ?? this.totalGmv,
      activeEscrowHold: activeEscrowHold ?? this.activeEscrowHold,
      totalCommissionEarned:
          totalCommissionEarned ?? this.totalCommissionEarned,
      totalBookingsCount: totalBookingsCount ?? this.totalBookingsCount,
      activeVendorsCount: activeVendorsCount ?? this.activeVendorsCount,
      activeUsersCount: activeUsersCount ?? this.activeUsersCount,
      satisfactionRate: satisfactionRate ?? this.satisfactionRate,
    );
  }
}

class VendorApplication {
  final String id;
  final String businessName;
  final String applicantName;
  final String category;
  final String location;
  final double startingPrice;
  final String portfolioUrl;
  final String insuranceDocRef;
  final DateTime appliedAt;
  final bool isApproved;

  const VendorApplication({
    required this.id,
    required this.businessName,
    required this.applicantName,
    required this.category,
    required this.location,
    required this.startingPrice,
    required this.portfolioUrl,
    required this.insuranceDocRef,
    required this.appliedAt,
    this.isApproved = false,
  });

  VendorApplication copyWith({
    String? businessName,
    String? applicantName,
    String? category,
    String? location,
    double? startingPrice,
    String? portfolioUrl,
    String? insuranceDocRef,
    bool? isApproved,
  }) {
    return VendorApplication(
      id: id,
      businessName: businessName ?? this.businessName,
      applicantName: applicantName ?? this.applicantName,
      category: category ?? this.category,
      location: location ?? this.location,
      startingPrice: startingPrice ?? this.startingPrice,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      insuranceDocRef: insuranceDocRef ?? this.insuranceDocRef,
      appliedAt: appliedAt,
      isApproved: isApproved ?? this.isApproved,
    );
  }
}

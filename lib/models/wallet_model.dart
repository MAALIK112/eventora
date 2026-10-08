enum TransactionType {
  topUp,
  bookingPayment,
  refund,
  cashbackReward,
}

enum PaymentMethodType {
  wallet,
  creditCard,
  applePay,
  googlePay,
  bankTransfer,
}

class PaymentMethodItem {
  final String id;
  final PaymentMethodType type;
  final String title;
  final String subtitle;
  final String? cardBrand;
  final String? last4;
  final String? expiryDate;
  final bool isDefault;

  const PaymentMethodItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    this.cardBrand,
    this.last4,
    this.expiryDate,
    this.isDefault = false,
  });
}

class WalletTransaction {
  final String id;
  final TransactionType type;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String referenceNumber;
  final String? relatedBookingId;
  final bool isSuccessful;

  const WalletTransaction({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.referenceNumber,
    this.relatedBookingId,
    this.isSuccessful = true,
  });
}

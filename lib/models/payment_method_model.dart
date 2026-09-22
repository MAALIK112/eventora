enum PaymentType { creditCard, paypal, cashOnDelivery, wallet }

class PaymentMethodModel {
  final String id;
  final String name;
  final String icon;
  final PaymentType type;
  final String? last4Digits;
  final bool isDefault;

  const PaymentMethodModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.last4Digits,
    this.isDefault = false,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      type: PaymentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaymentType.creditCard,
      ),
      last4Digits: json['last4Digits'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'type': type.name,
      'last4Digits': last4Digits,
      'isDefault': isDefault,
    };
  }
}

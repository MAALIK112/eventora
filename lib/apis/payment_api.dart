import 'dart:async';

class PaymentApi {
  final List<Map<String, dynamic>> _mockPaymentMethods = [
    {
      'id': 'pm_1',
      'type': 'card',
      'label': 'Visa ending 4242',
      'isDefault': true,
    },
    {
      'id': 'pm_2',
      'type': 'paypal',
      'label': 'PayPal',
      'isDefault': false,
    },
    {
      'id': 'pm_3',
      'type': 'cash',
      'label': 'Cash on Delivery',
      'isDefault': false,
    },
  ];

  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPaymentMethods;
  }

  Future<Map<String, dynamic>> createPaymentIntent(double amount) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return {
      'clientSecret': 'pi_mock_secret_${DateTime.now().millisecondsSinceEpoch}',
      'amount': amount,
      'status': 'requires_payment_method',
    };
  }

  Future<Map<String, dynamic>> confirmPayment(String paymentIntentId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return {
      'id': paymentIntentId,
      'status': 'succeeded',
    };
  }

  Future<void> addPaymentMethod(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _mockPaymentMethods.add({
      'id': 'pm_${DateTime.now().millisecondsSinceEpoch}',
      ...data,
      'isDefault': false,
    });
  }
}

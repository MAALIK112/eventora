import 'dart:async';

class WalletApi {
  double _balance = 2450.00;
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 't1',
      'type': 'deposit',
      'amount': 500.0,
      'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      'description': 'Added funds via Card ending in 4242',
    },
    {
      'id': 't2',
      'type': 'payment',
      'amount': -150.0,
      'date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      'description': 'Payment for DJ Service',
    },
    {
      'id': 't3',
      'type': 'refund',
      'amount': 300.0,
      'date': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      'description': 'Refund for cancelled booking',
    },
    {
      'id': 't4',
      'type': 'payment',
      'amount': -800.0,
      'date': DateTime.now().subtract(const Duration(days: 15)).toIso8601String(),
      'description': 'Payment for Security Team',
    },
    {
      'id': 't5',
      'type': 'deposit',
      'amount': 1000.0,
      'date': DateTime.now().subtract(const Duration(days: 20)).toIso8601String(),
      'description': 'Added funds via PayPal',
    },
    {
      'id': 't6',
      'type': 'payment',
      'amount': -1200.0,
      'date': DateTime.now().subtract(const Duration(days: 25)).toIso8601String(),
      'description': 'Payment for Live Band',
    },
    {
      'id': 't7',
      'type': 'deposit',
      'amount': 2000.0,
      'date': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'description': 'Initial deposit',
    },
    {
      'id': 't8',
      'type': 'payment',
      'amount': -50.0,
      'date': DateTime.now().subtract(const Duration(days: 31)).toIso8601String(),
      'description': 'Platform fee',
    },
  ];

  Future<double> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _balance;
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _transactions;
  }

  Future<Map<String, dynamic>> addFunds(double amount, String paymentMethodId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _balance += amount;
    final transaction = {
      'id': 't${DateTime.now().millisecondsSinceEpoch}',
      'type': 'deposit',
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
      'description': 'Added funds via $paymentMethodId',
    };
    _transactions.insert(0, transaction);
    return {
      'balance': _balance,
      'transaction': transaction,
    };
  }
}

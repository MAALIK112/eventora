import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/wallet_model.dart';
import '../services/mock_data_service.dart';

class WalletProvider extends ChangeNotifier {
  double _balance = 7873.0;
  double _escrowHold = 4275.0;
  List<WalletTransaction> _transactions = [];
  List<PaymentMethodItem> _paymentMethods = [];
  String _selectedMethodId = 'pm-wallet';

  WalletProvider() {
    _initData();
  }

  double get balance => _balance;
  double get escrowHold => _escrowHold;
  double get totalAssets => _balance + _escrowHold;
  List<WalletTransaction> get transactions => _transactions;
  List<PaymentMethodItem> get paymentMethods => _paymentMethods;
  String get selectedMethodId => _selectedMethodId;

  PaymentMethodItem get selectedPaymentMethod => _paymentMethods.firstWhere(
        (m) => m.id == _selectedMethodId,
        orElse: () => _paymentMethods.first,
      );

  void _initData() {
    _transactions = MockDataService.getInitialTransactions();
    _paymentMethods = MockDataService.getPaymentMethods();
    notifyListeners();
  }

  void selectPaymentMethod(String id) {
    _selectedMethodId = id;
    notifyListeners();
  }

  void topUpWallet({
    required double amount,
    required String fundingSource,
  }) {
    _balance += amount;
    final newTx = WalletTransaction(
      id: 'tx-${const Uuid().v4().substring(0, 8)}',
      type: TransactionType.topUp,
      title: 'Wallet Top-Up via $fundingSource',
      description: 'Funds available for luxury bookings and escrow security',
      amount: amount,
      date: DateTime.now(),
      referenceNumber: 'REF-TOP-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
    );
    _transactions.insert(0, newTx);
    notifyListeners();
  }

  void addPaymentCard({
    required String cardBrand,
    required String cardNumber,
    required String expiryDate,
    required String cardholderName,
  }) {
    final last4 = cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : '0000';
    final newMethod = PaymentMethodItem(
      id: 'pm-card-${DateTime.now().millisecondsSinceEpoch}',
      type: PaymentMethodType.creditCard,
      title: '$cardBrand (•••• $last4)',
      subtitle: 'Expires $expiryDate • $cardholderName',
      cardBrand: cardBrand,
      last4: last4,
      expiryDate: expiryDate,
    );
    _paymentMethods.add(newMethod);
    _selectedMethodId = newMethod.id;
    notifyListeners();
  }

  void recordBookingDeduction(double amount, String bookingId, String serviceTitle) {
    _balance -= amount;
    _escrowHold += amount;
    final newTx = WalletTransaction(
      id: 'tx-${const Uuid().v4().substring(0, 8)}',
      type: TransactionType.bookingPayment,
      title: 'Escrow Lock: $serviceTitle',
      description: 'Reserved deposit held for booking #$bookingId',
      amount: -amount,
      date: DateTime.now(),
      referenceNumber: 'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      relatedBookingId: bookingId,
    );
    _transactions.insert(0, newTx);
    notifyListeners();
  }
}

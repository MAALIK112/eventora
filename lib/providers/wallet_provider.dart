import 'package:flutter/foundation.dart';
import 'package:eventora/apis/wallet_api.dart';
import 'package:eventora/models/transaction_model.dart';
import 'package:eventora/providers/auth_provider.dart';

class WalletProvider extends ChangeNotifier {
  final WalletApi _walletApi = WalletApi();

  double _balance = 0.0;
  List<Transaction> _transactions = [];
  ViewState _state = ViewState.idle;

  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  ViewState get state => _state;

  Future<void> loadWallet() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _balance = await _walletApi.getBalance();
      await loadTransactions();
      _state = ViewState.success;
    } catch (e) {
      _state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> loadTransactions() async {
    try {
      final data = await _walletApi.getTransactions();
      _transactions = data.map((json) => Transaction.fromJson(json)).toList();
    } catch (e) {
      // Handle silently or update state
    }
  }

  Future<bool> addFunds(double amount, String paymentMethodId) async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final res = await _walletApi.addFunds(amount, paymentMethodId);
      _balance = res['balance'];
      _transactions.insert(0, Transaction.fromJson(res['transaction']));
      _state = ViewState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }
}

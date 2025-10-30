import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _userName = '';
  double _balance = 0.0;

  bool get isLoading => _isLoading;
  String get userName => _userName;
  double get balance => _balance;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setBalance(double amount) {
    _balance = amount;
    notifyListeners();
  }

  void updateBalance(double amount) {
    _balance += amount;
    notifyListeners();
  }
}
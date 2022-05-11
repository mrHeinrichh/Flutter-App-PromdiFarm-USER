import 'package:flutter/widgets.dart';

class LoginService extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  login() {
    _isLoggedIn = true;
    notifyListeners();
  }
}

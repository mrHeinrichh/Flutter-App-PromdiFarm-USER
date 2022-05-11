import 'package:flutter/widgets.dart';

class RiderProfile extends ChangeNotifier {
  bool updateProfile = false;

  bool get isLoggedIn => updateProfile;

  updateRider() {
    updateProfile = true;
    notifyListeners();
  }
}

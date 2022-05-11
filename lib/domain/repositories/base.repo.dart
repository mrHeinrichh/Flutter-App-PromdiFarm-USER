import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repository {
  final ApiService api;

  Repository({required this.api});

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(TOKEN) ?? "";
  }

  Future<void> setToken({required String token}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(TOKEN, token);
  }
}

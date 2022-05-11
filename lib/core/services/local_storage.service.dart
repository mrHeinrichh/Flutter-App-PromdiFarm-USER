import 'package:promdifarm_app/core/const/strings.dart';
import 'package:promdifarm_app/core/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final String _token = 'token';
  late SharedPreferences _sharedPreferences;
  final Future<SharedPreferences> Function() sharedPreferences;

  LocalStorageService({required this.sharedPreferences});

  init() async {
    _sharedPreferences = await sharedPreferences();
  }

  String getToken() {
    String? token = _sharedPreferences.getString(TOKEN);
    if (token == null) _sharedPreferences.setString(TOKEN, "");
    return token ?? "";
  }

  Map<String, dynamic> getParseToken() {
    final token = getToken();
    return token.isNotEmpty ? Utils.parseJwt(token) : {};
  }

  void setToken({required String token}) {
    _sharedPreferences.setString(_token, token);
  }

  clearStorage() async {
    await _sharedPreferences.setString(TOKEN, "");
  }
}

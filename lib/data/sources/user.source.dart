import 'dart:io';

import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/sources/index.dart';

class UserSourceImp extends UserSource {
  final DirectionsService dirService;
  final ApiService api;
  final LocalStorageService localStorage;
  final LoginService loginService;

  UserSourceImp({
    required this.dirService,
    required this.api,
    required this.localStorage,
    required this.loginService,
  });

  @override
  Future<Response> loginUser({
    String cred = "",
    String pass = "",
  }) async {
    var bodyReq = {"phoneNumber": cred, "password": pass};

    if (cred.toString().contains("@"))
      bodyReq = {"email": cred, "password": pass};

    Response response = await api.post(body: bodyReq, endpoint: "users/login");
    if (response.status != "success") throw RequestFailure(response.message);

    return response;
  }

  @override
  Future<Response> logout() async {
    Response response = await api.logout();
    loginService.logout();
    return response;
  }

  @override
  Future<User> getUserDetails() async {
    try {
      final token = localStorage.getParseToken();

      final response = await api.get(
        endpoint: "users/rider/${token['_id']}",
      );

      if (response.status != "success" && response.data.isEmpty) {
        throw RequestFailure("User not found!");
      }

      final user = User.fromJson(response.data[0]);
      return user;
    } catch (e) {
      throw NetworkFailure("Can't find user credentials!");
    }
  }

  @override
  Future<User> uploadAvatar(File file) async {
    try {
      final token = localStorage.getParseToken();

      final uploadRes = await api.postFile(image: file);
      if (uploadRes.status != "success")
        throw RequestFailure(uploadRes.message);

      final response = await api.patch(
        endpoint: "users/rider/${token['_id']}",
        body: {
          "avatar": uploadRes.data[0]["image"],
        },
      );
      if (response.status != "success" && response.data.isEmpty) {
        throw RequestFailure("Rider not found!");
      }

      final user = User.fromJson(response.data[0]);
      return user;
    } catch (e) {
      throw NetworkFailure("Can't find user credentials!");
    }
  }

  @override
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String email,
  }) async {
    var bodyReq = {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "email": email
    };
    final token = localStorage.getParseToken();

    Response response =
        await api.patch(body: bodyReq, endpoint: "users/rider/${token['_id']}");
    if (response.status != "success") throw RequestFailure(response.message);

    return response;
  }
}

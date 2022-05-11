import 'dart:io';

import 'package:promdifarm_app/data/models/index.dart';

abstract class UserSource {
  Future<Response> loginUser({
    String cred: "",
    String pass: "",
  });

  Future<Response> logout();
  Future<User> getUserDetails();
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String email,
  });
  Future<User> uploadAvatar(File file);
}

import 'dart:convert';
import 'dart:io';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/data/models/response.model.dart';

class ApiService {
  final LocalStorageService localStorage;
  final LoginService loginService;
  String accessToken = "";
  String api = dotenv.get('API', fallback: 'http://10.0.2.2:3333/') + 'api/v1/';

  ApiService({required this.localStorage, required this.loginService});

  get validate => {
        HttpHeaders.contentTypeHeader: "application/json",
        "X-Grant-Type": "refresh-token",
      };

  Future<Response> post({
    required Map<String, dynamic> body,
    required String endpoint,
  }) async {
    return send(
      (headers) => http.post(
        Uri.parse(api + endpoint),
        body: jsonEncode(body),
        headers: headers,
      ),
    );
  }

  Future<Response> postFile({
    required File image,
  }) async {
    return send(
      (headers) async {
        http.MultipartRequest request = new http.MultipartRequest(
          "POST",
          Uri.parse(api + "uploads"),
        )..headers.addAll(
            {
              ...headers,
              HttpHeaders.contentTypeHeader: "multipart/form-data",
            },
          );

        request.files.add(
          new http.MultipartFile(
              "file", image.readAsBytes().asStream(), image.lengthSync(),
              filename: image.path.split("/").last),
        );

        final response = await request.send();
        return http.Response.fromStream(response);
      },
    );
  }

  Future<Response> get({required String endpoint}) async {
    return send(
      (headers) => http.get(Uri.parse(api + endpoint), headers: headers),
    );
  }

  Future<Response> validateRefresh(token) async {
    await FkUserAgent.init();
    final userAgent = FkUserAgent.userAgent ?? "";
    return send(
      (headers) async => http.get(Uri.parse(api + "users/validate"), headers: {
        ...validate,
        "X-Refresh-Token": token,
        "User-Agent": userAgent
      }),
    );
  }

  Future<Response> patch({
    required Map<String, dynamic> body,
    required String endpoint,
  }) async {
    return send(
      (headers) => http.patch(
        Uri.parse(api + endpoint),
        body: jsonEncode(body),
        headers: headers,
      ),
    );
  }

  Future<Response> logout() async {
    final token = this.localStorage.getToken();
    final id = this.localStorage.getParseToken()["_id"];
    final body = {"token": token, "id": id};

    Response response = await send(
      (headers) => http.post(
        Uri.parse("${api}users/logout"),
        body: jsonEncode(body),
        headers: headers,
      ),
    );
    if (response.status != "success") throw RequestFailure(response.message);
    this.localStorage.setToken(token: "");
    return response;
  }

  Future<Response> send(
      Future<http.Response> Function(Map<String, String> headers)
          future) async {
    try {
      await FkUserAgent.init();
      String refreshToken = localStorage.getToken();

      if (refreshToken.isNotEmpty && accessToken.isEmpty) {
        await refreshedToken(refreshToken);
      }

      http.Response request = await future({
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + accessToken,
        "User-Agent": FkUserAgent.userAgent ?? ""
      });

      Response response = Response.fromJson(jsonDecode(request.body));
      String message = response.message.toLowerCase();

      if (message.contains("expired")) {
        await refreshedToken(refreshToken);
        return send(future);
      }

      if (response.meta.refresh.isNotEmpty) {
        localStorage.setToken(token: response.meta.refresh);
      }

      accessToken = response.meta.token;
      refreshToken = localStorage.getToken();

      if (refreshToken.isEmpty) {
        loginService.logout();
        throw "Please login again";
      }

      return response;
    } catch (e) {
      return Response.fromJson({"message": e.toString()});
    }
  }

  Future<void> refreshedToken(String refreshToken) async {
    final request = await http.get(
      Uri.parse(api + "users/validate"),
      headers: {
        ...validate,
        "X-Refresh-Token": refreshToken,
        "User-Agent": FkUserAgent.userAgent ?? ""
      },
    );
    final response = Response.fromJson(jsonDecode(request.body));
    accessToken = response.meta.token;
    localStorage.setToken(token: response.meta.refresh);
  }
}

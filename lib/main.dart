import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/core/routes/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promdifarm_app/core/services/index.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  final env = dotenv.get('ENV', fallback: '');

  if (env != "prod" || env != "production") {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    ByteData data =
        await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  init();
  final localStorage = sl<LocalStorageService>();
  await localStorage.init();
  final token = localStorage.getToken();
  Routes routes = sl<Routes>();
  GoRouter router = routes.getRouter(token);
  runApp(AppRoot(router));
}

class AppRoot extends StatelessWidget {
  final GoRouter router;
  AppRoot(this.router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

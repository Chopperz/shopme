import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/app/app_configs.dart';
import 'config/firebase/app_firebase.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppFirebase.instance.configs(isProduction: true);
  await dotenv.load(fileName: ".env");
  FlavorConfig(
      name: "PROD",
      color: const Color(0xff5b30f4),
      location: BannerLocation.topStart,
      variables: {
        "env": "production",
        "baseUrl": dotenv.env["BASE_URL"],
      }
  );

  runAppInitial();
}
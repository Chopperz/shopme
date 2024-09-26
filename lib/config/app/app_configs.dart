import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:shopme/config/router/router.dart';

void runAppInitial() async {
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ShopMe',
      theme: ThemeData(
        primaryColor: FlavorConfig.instance.color,
        colorScheme: ColorScheme.fromSeed(seedColor: FlavorConfig.instance.color),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.routerConfigs,
      builder: (BuildContext context, Widget? child) {
        bool isProd = (FlavorConfig.instance.name ?? "DEV") == "PROD";

        if (isProd) return child!;

        return Banner(
          message: FlavorConfig.instance.name ?? "DEV",
          location: FlavorConfig.instance.location,
          child: child!,
        );
      },
    );
  }
}
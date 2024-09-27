import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopme/config/l10n/l10n.dart';

import 'package:shopme/config/router/router.dart';
import 'package:shopme/core/constants/app_constants.dart';
import 'package:shopme/core/providers/providers.dart';
import 'package:shopme/core/services/services.dart';
import 'package:shopme/theme/app_theme.dart';

void runAppInitial() async {
  Directory dir = await getTemporaryDirectory();
  appDirectoryPath = dir.path;
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
  sharedPreferences = await SharedPreferences.getInstance();
  await DioService.initialize();
  await DynamicLinksService.instance.initDeepLinks();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(context)..add(const FetchUserEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
        selector: (state) => state.themeMode,
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'ShopMe',
            theme: AppTheme.instance.light,
            darkTheme: AppTheme.instance.dark,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.all,
            locale: _locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
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
        },
      ),
    );
  }
}

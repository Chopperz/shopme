part of '../app_theme.dart';

mixin _ThemeModeColor {
  ThemeData get light => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        primaryColor: FlavorConfig.instance.color,
        colorScheme: ColorScheme.fromSeed(
          primary: FlavorConfig.instance.color,
          seedColor: FlavorConfig.instance.color,
          inversePrimary: Colors.indigoAccent.shade400,
          secondary: Colors.indigo,
        ),
        scaffoldBackgroundColor: Colors.grey.shade100,
      );

  ThemeData get dark => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        cardColor: Colors.grey.shade900,
        primaryColor: FlavorConfig.instance.color,
        colorScheme: ColorScheme.dark(
          primary: FlavorConfig.instance.color,
          inversePrimary: Colors.indigoAccent.shade400,
        ),
      );
}

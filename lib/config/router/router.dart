import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopme/config/firebase/app_firebase.dart';
import 'package:shopme/feature/auth/login/login_screen.dart';
import 'package:shopme/feature/auth/register/register_screen.dart';
import 'package:shopme/feature/home/home_screen.dart';
import 'package:shopme/feature/landing/landing_screen.dart';
import 'package:shopme/feature/live/live_screen.dart';
import 'package:shopme/feature/profile/profile_screen.dart';
import 'package:shopme/feature/promotion/promotion_screen.dart';
import 'package:shopme/feature/setting/setting_screen.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

part 'src/routes/home_route.dart';

part 'src/routes/live_route.dart';

part 'src/routes/setting_route.dart';

part 'src/extensions.dart';

final class AppRouter {
  static AppRouter get instance => AppRouter._();

  factory AppRouter() => instance;

  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routerConfigs = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: "/",
    restorationScopeId: "restoration-app-route",
    routes: _initialRoutes,
    redirect: _redirect,
  );

  static Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    debugPrint("Redirect: Path => ${state.matchedLocation}");

    if (AppFirebase.instance.user == null) {
      String currentRouteName = (state.matchedLocation.split("/")..remove("")).last;
      return instance.isAuthPage(currentRouteName) ? state.matchedLocation : "/login";
    }

    return null;
  }

  static List<RouteBase> _initialRoutes = <RouteBase>[
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: navigatorKey,
      builder:
          (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
              LandingScreen(navigationShell: navigationShell),
      branches: [
        homeBranch,
        liveBranch,
        settingBranch,
      ],
    ),
    GoRoute(
      name: RouteName.login.name,
      path: RouteName.login.path,
      pageBuilder: (BuildContext context, GoRouterState state) => _MyCustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
      routes: [
        GoRoute(
          name: RouteName.register.name,
          path: RouteName.register.name,
          builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
        ),
      ],
    ),
  ];

  bool isMainPage(String path) =>
      [RouteName.home.path, RouteName.live.path, RouteName.setting.path].contains(path);

  bool isAuthPage(String path) => [RouteName.login.name, RouteName.register.name].contains(path);
}

class _MyCustomTransitionPage extends CustomTransitionPage {
  _MyCustomTransitionPage({required super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
}

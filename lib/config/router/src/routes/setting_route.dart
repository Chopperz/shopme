part of '../../router.dart';

StatefulShellBranch settingBranch = StatefulShellBranch(
  navigatorKey: GlobalKey(debugLabel: "setting-branch-key"),
  routes: [
    GoRoute(
      name: RouteName.setting.name,
      path: RouteName.setting.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingScreen();
      },
      routes: [
        GoRoute(
            name: RouteName.profile.path,
            path: RouteName.profile.path,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            }),
      ],
    ),
  ],
);

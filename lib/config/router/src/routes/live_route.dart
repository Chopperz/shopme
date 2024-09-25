part of '../../router.dart';

StatefulShellBranch liveBranch = StatefulShellBranch(
  routes: [
    GoRoute(
        name: RouteName.live.name,
        path: RouteName.live.path,
        builder: (BuildContext context, GoRouterState state) {
          return const LiveScreen();
        }
    ),
  ],
);

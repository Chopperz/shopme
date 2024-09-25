part of '../../router.dart';

StatefulShellBranch homeBranch = StatefulShellBranch(
  routes: [
    GoRoute(
      name: RouteName.home.name,
      path: RouteName.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen(title: "Home");
      },
      routes: [
        GoRoute(
          name: RouteName.promotion.path,
          path: RouteName.promotion.path,
          builder: (BuildContext context, GoRouterState state) {
            return const PromotionScreen();
          },
        ),
      ],
    ),
  ],
);

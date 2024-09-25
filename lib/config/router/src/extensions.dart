part of '../router.dart';

extension RouteNameExtensions on RouteName {
  String get path => switch (this) {
    RouteName.unknown => "/unknown",
    RouteName.home => "/",
    RouteName.profile => "profile/:id",
    RouteName.promotion => "promotion",
    RouteName.setting => "/setting",
    RouteName.live => "/live",
    RouteName.login => "/login",
    RouteName.register => "/register",
  };
}
import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:shopme/config/router/router.dart';

final class DynamicLinksService {
  DynamicLinksService._privateConstructor();

  static final DynamicLinksService _instance = DynamicLinksService._privateConstructor();

  static DynamicLinksService get instance => _instance;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialLink();
    if (appLink != null) {
      var uri = Uri.parse(appLink.toString());
      print(' here you can redirect from ${uri.path} as per your need ');
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen(
          (uriValue) {
        print(' you will listen any url updates ');
        print(' here you can redirect from url as per your need ');
        print(" uri-value :: ${uriValue.path}, ${AppRouter.navigatorKey.currentContext}");
        if (uriValue.path.isNotEmpty && AppRouter.navigatorKey.currentContext != null) {
          WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
            showDialog(
              context: AppRouter.navigatorKey.currentContext!,
              builder: (context) {
                return const Dialog(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Text("Alert"),
                  ),
                );
              },
            );
          });
        }
      },
      onError: (err) {
        debugPrint('====>>> error : $err');
      },
      onDone: () {
        _linkSubscription?.cancel();
      },
    );
  }
}
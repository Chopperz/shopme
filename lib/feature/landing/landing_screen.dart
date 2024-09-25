import 'package:flutter/material.dart';
import 'package:shopme/config/router/router.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    String currentUriPath = widget.navigationShell.shellRouteContext.routerState.uri.path;

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Visibility(
        visible: AppRouter.instance.isMainPage(currentUriPath),
        child: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (int index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: "Live",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}

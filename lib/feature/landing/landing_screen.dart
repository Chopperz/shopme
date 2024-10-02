import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme/config/router/router.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/providers/user_bloc/user_bloc.dart';

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

    return BlocListener<UserBloc, UserState>(
      listenWhen: (prev, curr) => prev.authStatus != curr.authStatus,
      listener: (context, state) {
        if (state.authStatus.isFailed) {
          context.goNamed(RouteName.login.name);
        }
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: Visibility(
          visible: AppRouter.instance.isMainPage(currentUriPath),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
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
        ),
      ),
    );
  }
}

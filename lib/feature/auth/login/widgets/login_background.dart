part of '../login_screen.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Hero(
      tag: "shopme-bg-authenticate",
      child: SizedBox(
        width: size.width,
        height: size.height / 1.9,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 70),
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/backgrounds/app-splash.png",
              width: 250,
            ),
          ),
        ),
      ),
    );
  }
}

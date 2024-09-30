part of '../register_screen.dart';

class RegisterAppBarBuilder extends StatelessWidget {
  const RegisterAppBarBuilder({super.key});

  static const double height = kToolbarHeight + 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceSize.width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 0, top: 30),
          alignment: Alignment.topLeft,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Hero(
                  tag: "app-logo-hero",
                  child: Image.asset(
                    "assets/images/backgrounds/app-splash.png",
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
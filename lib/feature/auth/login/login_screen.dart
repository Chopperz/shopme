import 'package:flutter/material.dart';
import 'package:shopme/config/router/router.dart';

export 'cubit/login_cubit.dart';

part 'widgets/login_authen_selection.dart';
part 'widgets/login_background.dart';

final List<String> _socialImages = const ['facebook', 'google', 'apple'];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: const LoginBackground(),
          ),
          Align(
            alignment: Alignment.center,
            child: const LoginAuthSelection(),
          ),
          Positioned(
            bottom: 80,
            child: Text(
              "Skip with Anonymous",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopme/config/app/app_configs.dart';
import 'package:shopme/config/router/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed(RouteName.register.name);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "LOGIN",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(),
    );
  }
}

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height / 1.9,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/backgrounds/app-splash.png",
                  width: 250,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 150),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome to ShopMe",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Discovery amazing thing near around You",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll<Size>(
                        Size(size.width - 60 - 40, 45),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      'Sign-In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll<Size>(
                        Size(size.width - 60 - 40, 45),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                    ),
                    child: Text(
                      'Sign-Up',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Divider(thickness: 1.2),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Or connect using',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: size.width,
                    height: 45,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

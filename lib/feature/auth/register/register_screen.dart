import 'package:flutter/material.dart';
import 'package:shopme/config/router/router.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/widgets/src/text_field/text_form_field.dart';

part 'widgets/register_app_bar_builder.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            child: const RegisterAppBarBuilder(),
          ),
          Positioned(
            top: kToolbarHeight + 50,
            left: 45,
            child: RichText(
              text: TextSpan(
                  text: "Sign Up  ",
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: "For create your account",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ]),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Container(
              width: context.deviceSize.width,
              height: context.deviceSize.height - kToolbarHeight,
              margin: const EdgeInsets.only(top: kToolbarHeight + 50),
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Registration Form",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextFormFiled(
                    title: "Firstname",
                    hintText: "Firstname",
                    isRequireField: true,
                  ),
                  const SizedBox(height: 10),
                  AppTextFormFiled(
                    title: "Lastname",
                    hintText: "Lastname",
                    isRequireField: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormFiled(
                          title: "Nickname",
                          hintText: "Nickname",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppTextFormFiled.datetime(
                          title: "Date of Birth",
                          hintText: "Your birthday",
                          isRequireField: true,
                          onSelectDateTime: (DateTime? datetime) {
                            //
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppTextFormFiled(
                    title: "Email",
                    hintText: "Email",
                    isRequireField: true,
                  ),
                  const SizedBox(height: 10),
                  AppTextFormFiled(
                    title: "Password",
                    hintText: "Password",
                    isRequireField: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormFiled(
                    title: "Confirm-Password",
                    hintText: "Confirm your password",
                    isRequireField: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll<Size>(
                        Size(context.deviceSize.width, 45),
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
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
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

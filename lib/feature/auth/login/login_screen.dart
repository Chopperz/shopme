import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme/config/router/router.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/services/src/dialog_service.dart';
import 'package:shopme/core/widgets/src/expandable_page_view.dart';
import 'package:shopme/core/widgets/src/text_field/text_form_field.dart';
import 'package:shopme/feature/auth/login/cubit/login_cubit.dart';
import 'package:shopme/feature/auth/login/cubit/login_cubit.dart';

export 'cubit/login_cubit.dart';

part 'widgets/login_authen_selection_view.dart';

part 'widgets/login_form_view.dart';

part 'widgets/login_background.dart';

final List<String> _socialImages = const ['facebook', 'google', 'apple'];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentPage = 0;

  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              width: context.deviceSize.width,
              margin: EdgeInsets.symmetric(horizontal: 30).copyWith(
                top: currentPage == 0 ? 150 : 100,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpandablePageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: 2,
                onPageChanged: (int page) {
                  setState(() => currentPage = page);
                },
                itemBuilder: (_, int index) {
                  return [
                    LoginAuthSelectionView(
                      onSelectAuthDirection: (LoginAuthType auth) {
                        if (auth == LoginAuthType.member) {
                          onAnimateToPage(1);
                        }
                      },
                    ),
                    LoginFormView(
                      onBack: () {
                        onAnimateToPage(0);
                        context.read<LoginCubit>().onClearFormField();
                      },
                    ),
                  ].elementAt(index);
                },
              ),
            ),
          ),
          Visibility(
            visible: FocusScope.of(context).hasPrimaryFocus,
            child: Positioned(
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
          ),
        ],
      ),
    );
  }

  void onAnimateToPage(int page) => pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
}

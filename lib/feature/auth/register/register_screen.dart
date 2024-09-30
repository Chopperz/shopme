import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopme/config/router/router.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/services/src/dialog_service.dart';
import 'package:shopme/core/widgets/src/text_field/text_form_field.dart';
import 'package:shopme/feature/auth/register/cubit/register_cubit.dart';

part 'widgets/register_app_bar_builder.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        print(state.status);
        if (state.status.isSuccess) {
          context.goNamed(RouteName.home.name);
        }

        if (state.status.isFailed) {
          DialogService().showMessage(
            context,
            type: DialogMessageType.ERROR,
            message: state.messageError ?? "Something there's incorrect.",
          );
        }
      },
      builder: (context, state) {
        RegisterCubit provider = context.read<RegisterCubit>();

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
                  child: state.status.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ListView(
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
                              onChanged: (String value) => provider.onFirstNameChanged(value),
                            ),
                            const SizedBox(height: 10),
                            AppTextFormFiled(
                              title: "Lastname",
                              hintText: "Lastname",
                              isRequireField: true,
                              onChanged: (String value) => provider.onLastNameChanged(value),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: AppTextFormFiled(
                                    title: "Nickname",
                                    hintText: "Nickname (Optional)",
                                    onChanged: (String value) {
                                      provider.onNicknameChanged(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: AppTextFormFiled.datetime(
                                    title: "Date of Birth",
                                    hintText: "Your birthday",
                                    isRequireField: true,
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(text: state.user.dateOfBirth ?? "")),
                                    onSelectDateTime: (DateTime? dateTime) {
                                      if (dateTime != null) {
                                        String dob =
                                            DateFormat("yyyy-MM-dd").format(dateTime).toString();
                                        provider.onDateOfBirthSelected(dob);
                                      }
                                      FocusScope.of(context).unfocus();
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
                              errorText: state.errorText.emailError,
                              onChanged: (value) => provider.onEmailChanged(value),
                            ),
                            const SizedBox(height: 10),
                            AppTextFormFiled(
                              title: "Password",
                              hintText: "Password",
                              isRequireField: true,
                              obscureText: isObscurePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => isObscurePassword = !isObscurePassword);
                                },
                                icon: Icon(
                                    isObscurePassword ? Icons.visibility : Icons.visibility_off,
                                    size: 20),
                              ),
                              onChanged: (value) => provider.onPasswordChanged(value),
                            ),
                            const SizedBox(height: 10),
                            AppTextFormFiled(
                              title: "Confirm-Password",
                              hintText: "Confirm your password",
                              isRequireField: true,
                              errorText: state.errorText.confirmError,
                              obscureText: isObscureConfirmPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(
                                      () => isObscureConfirmPassword = !isObscureConfirmPassword);
                                },
                                icon: Icon(
                                    isObscureConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20),
                              ),
                              onChanged: (value) => provider.onConfirmPasswordChanged(value),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (state.isAvailableToSignUp) {
                                  provider.onSignUp();
                                }
                              },
                              style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll<Size>(
                                  Size(context.deviceSize.width, 45),
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                  if (state.isAvailableToSignUp) {
                                    return context.theme.primaryColor;
                                  }
                                  return Colors.grey.shade400;
                                }),
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
      },
    );
  }
}

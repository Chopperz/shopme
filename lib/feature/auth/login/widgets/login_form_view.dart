part of '../login_screen.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const SizedBox(
            width: 250,
            height: 250,
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      InkWell(
                        onTap: () => widget.onBack(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.grey.shade500,
                              size: 14,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Please sign in to continue.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppTextFormFiled(
              controller: emailController,
              hintText: "Email",
              prefixIcon: const Icon(Icons.email, size: 20),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (text) => context.read<LoginCubit>().onEmailChanged(text),
            ),
            const SizedBox(height: 10),
            BlocSelector<LoginCubit, LoginState, bool>(
              selector: (state) => state.isObscurePassword,
              builder: (context, isObscurePassword) {
                return AppTextFormFiled(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: isObscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock, size: 20),
                  suffixIcon: InkWell(
                    onTap: () => context.read<LoginCubit>().onToggleObscurePassword(),
                    child:
                        Icon(isObscurePassword ? Icons.visibility : Icons.visibility_off, size: 20),
                  ),
                  onChanged: (text) => context.read<LoginCubit>().onPasswordChanged(text),
                );
              },
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            BlocSelector<LoginCubit, LoginState, bool>(
              selector: (state) => state.isAvailableToSignIn,
              builder: (context, isAvailableToSignIn) {
                return ElevatedButton(
                  onPressed: () => context.read<LoginCubit>().onSignIn(),
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll<Size>(
                      Size(context.deviceSize.width - 60 - 40, 45),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (isAvailableToSignIn) {
                        return context.theme.primaryColor;
                      }
                      return Colors.grey.shade400;
                    }),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

part of 'login_cubit.dart';

final class LoginState extends Equatable {
  final StateStatus status;
  final String email;
  final String password;
  final bool isObscurePassword;
  final String? errorText;
  final String? messageError;

  const LoginState({
    this.status = StateStatus.init,
    this.email = "",
    this.password = "",
    this.isObscurePassword = true,
    this.errorText,
    this.messageError,
  });

  LoginState copyWith({
    StateStatus? status,
    String? email,
    String? password,
    bool? isObscurePassword,
    String? errorText,
    String? messageError,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      errorText: errorText,
      messageError: messageError,
    );
  }

  bool get isAvailableToSignIn => email.isNotEmpty && password.isNotEmpty && errorText == null;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isObscurePassword,
        errorText,
        messageError,
      ];
}

part of 'register_cubit.dart';

class RegisterErrorMatch {
  final String? emailError;
  final String? confirmError;

  const RegisterErrorMatch({
    this.emailError,
    this.confirmError,
  });

  RegisterErrorMatch copyWith({
    String? emailError,
    String? confirmError,
  }) {
    return RegisterErrorMatch(
      emailError: emailError,
      confirmError: confirmError,
    );
  }

  bool get isInValid => emailError.isNotEmptyOrNull || confirmError.isNotEmptyOrNull;
}

final class RegisterState extends Equatable {
  final StateStatus status;
  final UserModel user;
  final String email;
  final String password;
  final String confirmPassword;
  final RegisterErrorMatch errorText;
  final String? messageError;

  const RegisterState({
    this.status = StateStatus.init,
    this.user = const UserModel(),
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.errorText = const RegisterErrorMatch(),
    this.messageError,
  });

  RegisterState copyWith({
    StateStatus? status,
    UserModel? user,
    String? email,
    String? password,
    String? confirmPassword,
    RegisterErrorMatch? errorText,
    String? messageError,
  }) {
    return RegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorText: errorText ?? this.errorText,
      messageError: messageError,
    );
  }

  bool get isInformationValid =>
      user.firstName.isNotEmptyOrNull &&
      user.lastName.isNotEmptyOrNull &&
      user.dateOfBirth.isNotEmptyOrNull;

  bool get isAvailableToSignUp =>
      email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && !errorText.isInValid && isInformationValid;

  @override
  List<Object?> get props => [
        status,
        user,
        email,
        password,
        confirmPassword,
        errorText,
        messageError,
      ];
}

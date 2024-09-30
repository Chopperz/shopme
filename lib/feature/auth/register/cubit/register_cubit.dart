import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme/config/firebase/app_firebase.dart';
import 'package:shopme/core/enums/enums.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/models/src/user/user_model.dart';
import 'package:uuid/uuid.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onFirstNameChanged(String firstname) {
    emit(state.copyWith(
      user: state.user.copyWith(firstName: firstname),
    ));
  }

  void onLastNameChanged(String lastname) {
    emit(state.copyWith(
      user: state.user.copyWith(lastName: lastname),
    ));
  }

  void onNicknameChanged(String nickname) {
    emit(state.copyWith(
      user: state.user.copyWith(nickName: nickname),
    ));
  }

  void onDateOfBirthSelected(String dob) {
    emit(state.copyWith(
      user: state.user.copyWith(dateOfBirth: dob),
    ));
  }

  void onEmailChanged(String email) {
    String? errorText;

    if (email.isNotEmpty && !AppRegExp.isEmail.regExp.hasMatch(email)) {
      errorText = "Email is invalid.";
    }

    emit(state.copyWith(
      email: email,
      errorText: state.errorText.copyWith(emailError: errorText ?? ""),
    ));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    String? errorText;

    if (confirmPassword != state.password) {
      errorText = "Your password isn't match.";
    }

    emit(state.copyWith(
      confirmPassword: confirmPassword,
      errorText: state.errorText.copyWith(confirmError: errorText ?? ""),
    ));
  }

  Future<void> onSignUp() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      UserCredential? credential =
          await AppFirebase.instance.signUpWithEmailAndPassword(state.email, state.password);

      if (credential != null) {
        DatabaseReference ref = AppFirebase.instance.database(path: "users");
        String userId = credential.user?.uid ?? Uuid().v1();
        await ref.update({
          userId: state.user.toJson(),
        });

        if (credential.credential != null) {
          await AppFirebase.instance.auth.signInWithCredential(credential.credential!);
        }

        emit(state.copyWith(status: StateStatus.success));
      } else {
        emit(state.copyWith(status: StateStatus.failed));
        await Future.delayed(const Duration(seconds: 1));
      }
    } on FirebaseAuthException catch (err) {
      emit(state.copyWith(
        status: StateStatus.failed,
        messageError: err.message,
      ));
    }

    emit(state.copyWith(status: StateStatus.done));
  }
}

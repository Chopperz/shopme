import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme/core/enums/src/state_status.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onToggleObscurePassword() => emit(state.copyWith(
        isObscurePassword: !state.isObscurePassword,
      ));

  void onClearFormField() => emit(state.copyWith(email: "", password: ""));

  Future<void> onSignIn() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: state.email, password: state.password);

      if (userCredential.user == null) {
        emit(state.copyWith(status: StateStatus.failed));
      } else {
        emit(state.copyWith(status: StateStatus.success));
      }
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
        status: StateStatus.failed,
        messageError: error.message,
      ));
    }
  }
}

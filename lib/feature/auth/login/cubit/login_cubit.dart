import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopme/config/firebase/app_firebase.dart';
import 'package:shopme/core/enums/src/state_status.dart';
import 'package:shopme/core/models/models.dart';
import 'package:shopme/core/repositories/repositories.dart';

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

  void onSignInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    // emit(state.copyWith(status: StateStatus.loading));

    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }

      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth == null) {
        emit(state.copyWith(
          status: StateStatus.failed,
          messageError: GoogleSignIn.kSignInFailedError,
        ));
        return;
      }

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await AppFirebase.instance.auth.signInWithCredential(authCredential);

      if (userCredential.user == null) {
        emit(state.copyWith(status: StateStatus.failed));
      } else {
        if (!await UserRepository().isUserExists(userCredential.user!.uid)) {
          List<String> displayNameWithSplit = (googleUser?.displayName ?? "").split(" ");
          await UserRepository().createUser(
            userCredential,
            user: UserModel(
              firstName: displayNameWithSplit.isNotEmpty ? displayNameWithSplit.first : "",
              lastName: displayNameWithSplit.isNotEmpty && displayNameWithSplit.length > 1
                  ? displayNameWithSplit.last
                  : "",
              email: googleUser?.email,
              avatarImage: googleUser?.photoUrl,
            ),
          );
        }

        emit(state.copyWith(status: StateStatus.success));
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

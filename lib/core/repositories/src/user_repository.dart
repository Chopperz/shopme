import 'package:shopme/config/firebase/app_firebase.dart';
import 'package:shopme/core/models/models.dart';
import 'package:shopme/core/services/dio/dio_service.dart';
import 'package:uuid/uuid.dart';

final class UserRepository {
  static UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() => _instance;

  Future<void> userLogIn() async {
    //
  }

  Future<void> refreshToken({String? userAccessToken}) async {
    //
  }

  Future<void> createUser(UserCredential credential, {required UserModel user}) async {
    DatabaseReference ref = AppFirebase.instance.database(path: "users");
    String userId = credential.user?.uid ?? Uuid().v1();
    await ref.update({
      userId: user.toJson(),
    });
  }

  Future<void> userLogout() async {
    await DioService.resetStatic();
    await AppFirebase.instance.logout();
  }

  Future<bool> isUserExists(String uid) async {
    final userData = await AppFirebase.instance.database().child('users');
    final DataSnapshot info = await userData.child(uid).get();
    return info.exists;
  }
}

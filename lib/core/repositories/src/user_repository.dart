import 'package:shopme/config/firebase/app_firebase.dart';
import 'package:shopme/core/services/dio/dio_service.dart';

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

  Future<void> userLogout() async {
    await DioService.resetStatic();
    await AppFirebase.instance.logout();
  }
}

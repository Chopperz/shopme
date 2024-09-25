import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_database/firebase_database.dart';

import 'src/dev_firebase_options.dart';
import 'src/prod_firebase_options.dart';

class AppFirebase {
  static AppFirebase instance = AppFirebase._();

  AppFirebase._();

  Future<void> configs({bool isProduction = false}) async {
    if (isProduction) {
      await Firebase.initializeApp(
        options: DefaultFirebaseProdOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseDevOptions.currentPlatform,
      );
    }
    // await FirebaseAuth.instance..useAuthEmulator("localhost", 9099);
  }

  FirebaseAuth get auth => FirebaseAuth.instance;

  User? get user => auth.currentUser;

  DatabaseReference database({String? path}) => FirebaseDatabase.instance.ref(path);

  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((UserCredential value) {
      return value;
    }).catchError((error) {
      throw "FirebaseAuth-createUser Error ==> ${error.message}";
    });
  }

  Future<void> logout() async => await auth.signOut();
}
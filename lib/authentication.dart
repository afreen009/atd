import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  // 1
  final FirebaseAuth _firebaseAuth;
  Future prefs = SharedPreferences.getInstance();
  AuthenticationService(this._firebaseAuth);
  String uid = "";
  // 2
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // 3
  Future<String> signIn({String email, String password}) async {
    try {
    var response =  await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          print("response ${response.user.uid}");
      (await prefs).setString('uid', response.user.uid);     
      print((await prefs).getString('uid'));
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 4
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 5
  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

// 6
  User getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}

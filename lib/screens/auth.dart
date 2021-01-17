import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth;
  Auth(this._auth);
  Stream<User> get authStateChanges => _auth.authStateChanges();
  Future<bool> signInWithEmailAndPassword(
      Map<String, dynamic> userDetails) async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: userDetails['email'],
        password: userDetails['password'],
      );

      if (user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<bool> register(Map<String, dynamic> userDetails) async {
    try {
      final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: userDetails['email'],
        password: userDetails['password'],
      );

      if (user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

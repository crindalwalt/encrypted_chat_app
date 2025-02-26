import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider1 extends ChangeNotifier {
  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;

  Future<String> signIn(String email, String password) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userCredential = null;
    notifyListeners();
  }
}

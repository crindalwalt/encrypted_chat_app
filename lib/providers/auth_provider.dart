import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider1 extends ChangeNotifier {
  UserCredential? _user;
  UserCredential? get userr => _user;

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential cruntuser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _user = cruntuser;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential cruntuser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = cruntuser;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}

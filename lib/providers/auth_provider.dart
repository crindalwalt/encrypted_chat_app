import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider1 extends ChangeNotifier {
  FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  UserCredential? _user;
  UserCredential? get userr => _user;

  Future<bool> isUserEmailVerified() async {
    await currentUser?.reload();
    currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.emailVerified ?? false;
  }

  Future<void> sendVerificationEmail() async {
    if (currentUser != null) {
      print("sending verification email now ....");
      await currentUser?.sendEmailVerification();
    }
  }

  // Login existing user
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

  // Register a new user
  Future<String?> signUp(String name,String email, String password) async {
    try {
      UserCredential cruntuser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final userInFirestore = await _database.collection("users").add({
        "name" : name,
        "email" : email,
        "verified" : false,
        "createdAt" : FieldValue.serverTimestamp(),
      });
      _user = cruntuser;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }




  Stream<QuerySnapshot> getAllUsers () {
    final allUsers = _database.collection("users").snapshots();
    return allUsers;
  }
}

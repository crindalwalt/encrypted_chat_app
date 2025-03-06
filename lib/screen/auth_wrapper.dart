import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/chatdetail.dart';
import 'package:encrypted_chat_app/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider1>(context);

    return StreamBuilder(
      stream: authProvider.firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ChatDetailScreen();
        }

        return LoginScreen();
      },
    );
  }
}

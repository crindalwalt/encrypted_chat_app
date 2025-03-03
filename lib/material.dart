import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/auth_wrapper.dart';
import 'package:encrypted_chat_app/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider1()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

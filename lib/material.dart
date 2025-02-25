import 'package:encrypted_chat_app/screen/loginscreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home:LoginScreen(),
    );
  }
}
import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/chatscreen.dart';
import 'package:encrypted_chat_app/screen/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider1>(context);
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    void login() {
      if (_formKey.currentState!.validate()) {
        authprovider
            .signIn(_emailController.text, _passwordController.text)
            .then((value) {
          if (value == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Signed in'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value),
              ),
            );
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FlutterLogo(
                    size: 150,
                  )),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(' Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

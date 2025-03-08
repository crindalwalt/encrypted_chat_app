import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/chatdetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;

  void sendOtp() {
    if (emailController.text.isNotEmpty || phoneController.text.isNotEmpty) {
      setState(() {
        isOtpSent = true;
      });
    }
  }

  void verifyOtp() {
    if (otpController.text.length == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider1>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isOtpSent ? "Enter OTP" : "Verify Your Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  if (!isOtpSent) ...[
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: sendOtp,
                      child: Text("Send OTP"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ] else ...[
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Enter 6-digit OTP",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: verifyOtp,
                      child: Text("Verify OTP"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                  Expanded(
                    child: FutureBuilder(
                      future: authService.isUserEmailVerified(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.data != true) {
                          return ListTile(
                            title: Text("Email not verified"),
                            leading: Icon(Icons.cancel),
                            trailing: IconButton(
                              onPressed: () {
                                authService.sendVerificationEmail();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Verification email sent")),
                                );
                              },
                              icon: Icon(Icons.send),
                            ),
                          );
                        }
                        return Text("Email Verified");
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatDetailScreen(),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text("Chat $index"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}











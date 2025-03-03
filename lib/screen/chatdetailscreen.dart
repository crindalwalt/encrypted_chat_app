import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/chatscreen.dart';
import 'package:encrypted_chat_app/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider1>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatsDetail'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              print("logging user out...");
              authService.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen())
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(child: FutureBuilder(future: authService.isUserEmailVerified(), builder: (context,snapshot){
            print(snapshot.data);
            if(snapshot.data != true){
              return ListTile(
                title: Text("Email not verified"),
                leading: Icon(Icons.cancel),
                trailing: IconButton(onPressed: () {
                   authService.sendVerificationEmail();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification email send")));
                }, icon: Icon(Icons.send)),
              );
            }
            return Text("Email Verified");
          })),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Thinkcode $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Last message...',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '12:30 PM',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '5',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

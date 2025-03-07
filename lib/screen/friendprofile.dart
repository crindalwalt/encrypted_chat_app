import 'package:encrypted_chat_app/screen/chat.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String userName;
  final String userImage;
  final String userBio;
  final List<String> userFriends;

  UserProfileScreen({
    required this.userName,
    required this.userImage,
    required this.userBio,
    required this.userFriends,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCoverPhoto(),
            _buildHeader(),
            _buildBio(),
            _buildFriendsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverPhoto() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(userImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userImage),
          ),
          SizedBox(width: 16.0),
          Text(
            userName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        userBio,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFriendsList() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friends',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: userFriends.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userFriends[index]),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add Friend'),
                              content: Text('Are you sure you want to add Friend Name $index as a friend?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Add Friend'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Add Friend'),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

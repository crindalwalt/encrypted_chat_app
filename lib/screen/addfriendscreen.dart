import 'package:encrypted_chat_app/providers/auth_provider.dart';
import 'package:encrypted_chat_app/screen/friendprofilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider1>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Friend')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: authProvider.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Icon(Icons.cancel);
                }

                final data = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: InkWell(
                          onTap:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => UserProfileScreen(
                                        userName: 'Friend Name $index',
                                        userImage:
                                            'https://images.pexels.com/photos/14255377/pexels-photo-14255377.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                        userBio:
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nisl nec nunc ultricies luctus. Nullam nec ultricies nunc. Sed nec nunc ultricies, ultricies nunc nec, ultricies nunc.',
                                        userFriends: [
                                          'https://images.pexels.com/photos/14363794/pexels-photo-14363794.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/19035898/pexels-photo-19035898/free-photo-of-close-up-of-cat.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/8536880/pexels-photo-8536880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/8706371/pexels-photo-8706371.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/9428693/pexels-photo-9428693.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/17685201/pexels-photo-17685201/free-photo-of-photo-of-a-furry-ragdoll-cat.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/30271412/pexels-photo-30271412/free-photo-of-chained-siberian-husky-relaxing-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/19035898/pexels-photo-19035898/free-photo-of-close-up-of-cat.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          'https://images.pexels.com/photos/19035898/pexels-photo-19035898/free-photo-of-close-up-of-cat.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                        ],
                                      ),
                                ),
                              ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/14255377/pexels-photo-14255377.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            ),
                          ),
                        ),
                        title: Text(data[index]['name']),
                        subtitle: Text('Friend details here'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Add Friend'),
                                  content: Text(
                                    'Are you sure you want to add Friend Name $index as a friend?',
                                  ),
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
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

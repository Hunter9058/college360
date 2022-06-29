import 'package:college360/home_pages/chat/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../constant.dart';

class ChatMain extends StatefulWidget {
  @override
  State<ChatMain> createState() => _ChatMainState();
}

void _handlePressed(types.User otherUser, BuildContext context) async {
  final navigator = Navigator.of(context);
  final room = await FirebaseChatCore.instance.createRoom(otherUser);

  navigator.pop();
  await navigator.push(
    MaterialPageRoute(
      builder: (context) => ChatPage(
        room: room,
      ),
    ),
  );
}

class _ChatMainState extends State<ChatMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<types.User>>(
        //todo add user search functionality and remove full retrivel
        //retrieve all user in database auth
        stream: FirebaseChatCore.instance.users(),
        initialData: const [],
        builder: (context, snapshot) {
          //checking for nullability
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No users'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  _handlePressed(user, context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(user),
                      Text(getUserName(user)),
                    ],
                  ),
                ),
              );
            },
          );
          // ...
        },
      ),
    );
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }
}

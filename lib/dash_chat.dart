
import 'package:amochat/main.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';





class DsahChat extends StatefulWidget {
  const DsahChat({Key? key}) : super(key: key);

  @override
  State<DsahChat> createState() => _DsahChatState();
}

class _DsahChatState extends State<DsahChat> {
  ChatUser user = ChatUser(id: '1',
    firstName: 'Buba',
    lastName: 'sanneh',
    profileImage: 'Image',
  );
  List<ChatMessage> messages = <ChatMessage>[
//    ChatMessage( createdAt: DateTime.now(),text: 'Hey', user: user,)
  ];
  @override
  Widget build(BuildContext context) {
    return AmoChat();
  }
}

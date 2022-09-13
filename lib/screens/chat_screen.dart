import 'dart:core';
import 'dart:math';
import 'package:amochat/constants.dart';
import 'package:amochat/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User get loggedInUser => _auth.currentUser!;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  ChatScreen({Key? key, required uid}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  bool _canSendMessage = false;
  XFile? _image;
  int _page = 0;
  late PageController pageController;





  @override
  void initState() {
    super.initState();

    messageTextController.addListener(() {
      final canSendMessage = messageTextController.text.isNotEmpty;
      if (_canSendMessage != canSendMessage) {
        setState(() {
          _canSendMessage = canSendMessage;
        });
      }
    });
  }


  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: () => SearchScreen,
            icon: Icon(
              Icons.search,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.green,
            ),
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.keyboard_voice_rounded),
                        ),
                        TextButton(
                          onPressed: () async {
                            _image = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                          },
                          child: Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.lightGreen,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.call,
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: _canSendMessage ? _sendMessage : null,
                            child: Text(
                              'Send',
                              style: _canSendMessage
                                  ? kSendButtonTextStyle
                                  : kSendButtonDisabledTextStyle,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() async {
    String? url;
    if (_image != null) {
      final storageReferencePath = 'myImage${Random().nextInt(1000)}';
      final storageReference =
          FirebaseStorage.instance.ref().child(storageReferencePath);
      await storageReference.putFile(File(_image!.path));
      url = await storageReference.getDownloadURL();
    }
    _firestore.collection('messages').add({
      'text': messageTextController.text,
      'sender': loggedInUser.uid,
      'createAt': Timestamp.now(),
      'userId': loggedInUser.uid,
      'url': url,
    });
    messageTextController.clear();
    _image = null;
  }

  pickImage({required ImageSource source}) {
    ImagePicker().pickImage(source: ImageSource.camera);
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy('createAt').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs;
          print(messages);

          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: loggedInUser.uid == messageSender,
              userId: AutofillHints.username,
              url: message.data()['url'],
            );
            messageBubbles.add(messageBubble);
          }
          print(messageBubbles.length);

          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: messageBubbles,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
    required this.isMe,
    required this.userId,
    this.url,
  });

  final String sender;
  final String text;
  final String userId;
  final bool isMe;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          if (url != null)
            Image.network(
              url!,
              width: 200,
              height: 200,
            ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:amochat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final FirebaseUser loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getLoggedInUser();
  }

  @override
  void setState(AmoChat) {
    super.initState();
    getLoggedInUser();
  }

  void getLoggedInUser() async {
    final user = await loggedInUser;
    loggedInUser = user;
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      loggedInUser = user as FirebaseUser;
      loggedInUser;
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  // final messages = await _firestore.collectionGroup('messages').get();
  //for(var message in messages.docs) {
  //print(message.data);

  //}
//  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                messagesStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                stream: _firestore.collection('messages').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {}
                  final messages = snapshot.data?.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages!) {
                    final messageText = message.data();
                    final messageSender = message.data();
                    final messageWidget =
                        Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: messageWidgets,
                  );
                },
              ),
            ),
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreenAccent,
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //messagesText + loggedInUser;
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirebaseUser {
  late String loggedInUser;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(loggedInUser),
    );
  }
}

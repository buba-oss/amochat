import 'package:amochat/screens/chat_screen.dart';
import 'package:amochat/screens/login_screen.dart';
import 'package:amochat/screens/registration_screen.dart';
import 'package:amochat/screens/welcome_screen.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AmoChat(messages: [],),);
}

class AmoChat extends StatelessWidget {
  AmoChat(Null Function(ChatMessage m) param0, {required List<ChatMessage> messages});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

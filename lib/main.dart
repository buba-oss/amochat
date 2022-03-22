import 'package:amochat/screens/chat_screen.dart';
import 'package:amochat/screens/login_screen.dart';
import 'package:amochat/screens/registration_screen.dart';
import 'package:amochat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AmoChat());




class AmoChat extends StatelessWidget {
  const AmoChat({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute:  WelcomeScreen.id,
      routes: {
       WelcomeScreen.id:(context) => WelcomeScreen(),
       RegistrationScreen.id:(context) => RegistrationScreen(),
       LoginScreen.id:(context) => LoginScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
    );
  }
}

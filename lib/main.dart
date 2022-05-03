import 'package:amochat/screens/chat_screen.dart';
import 'package:amochat/screens/login_screen.dart';
import 'package:amochat/screens/registration_screen.dart';
import 'package:amochat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AmoChat());
}

class AmoChat extends StatelessWidget {
  const AmoChat();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // if user has signed in, auto sign in on next
      initialRoute: FirebaseAuth.instance.currentUser != null ? ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

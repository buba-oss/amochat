import 'package:amochat/%20modal_progress_hud/modal_progress_hud.dart';
import 'package:amochat/constants.dart';
import 'package:amochat/responsive/mobil_screen_layout.dart';
import 'package:amochat/responsive/responsive_layout_screen.dart';
import 'package:amochat/responsive/web_screen_layout.dart';
import 'package:amochat/screens/chat_screen.dart';
import 'package:amochat/screens/login_screen.dart';
import 'package:amochat/screens/registration_screen.dart';
import 'package:amochat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyD1azGqUK6Sdq4X4pf2b7RjwtVM9cxvAKc',
        appId: '1:874131745945:web:73c320a456d8d5f3651c08',
        messagingSenderId: '874131745945',
        projectId: 'amo-chat-41c0f',
        storageBucket: 'amo-chat-41c0f.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(AmoChat());
}

class AmoChat extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ChatScreen.id: (context) => ChatScreen(uid: null,),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ( context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active)
              if (snapshot.hasData) {
              return const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return WelcomeScreen();
          },
        ),
      ),
    );
  }
}

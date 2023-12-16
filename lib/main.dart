import 'package:flutter/material.dart';
import 'package:flutter_1/pages/single-post-view.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:flutter_1/resources/auth.dart';
import 'package:flutter_1/email_and_pass.dart';
import 'package:flutter_1/pages/homepage.dart';
import 'package:flutter_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_1/responsive/responsive_layout_screen.dart';
import 'package:flutter_1/responsive/web_screen_layout.dart';
import 'package:flutter_1/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_1/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'text_and_space.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontFamily: GoogleFonts.dancingScript().fontFamily,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              labelSmall: TextStyle(
                fontFamily: GoogleFonts.eduTasBeginner().fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide.none,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => const LoginPage(),
          '/home': (BuildContext context) => const MyHomePage(),
          '/signup': (BuildContext context) => SignUpPage()
        },
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MyHomePage());
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}

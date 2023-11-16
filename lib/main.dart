import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/auth.dart';
import 'package:flutter_1/email_and_pass.dart';
import 'package:flutter_1/homepage.dart';
import 'package:flutter_1/signup.dart';
import 'package:firebase_core/firebase_core.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const MyHomePage(title: 'Home Page'),
        '/signup': (BuildContext context) => SignUpPage()
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(title: 'Home Page');
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  final String title = 'Instaclone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const SizedBox.expand(
          child: Stack(
            children: [
              GradientBackdrop(), LoginForm()
              // Positioned(top: 120, left: 10, right: 10, child: LoginForm()),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final double formWidth = 320;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  String? emailError;
  String? passwordError;

  void handleError(errorMessage) {
    if (errorMessage.contains('password')) {
      setState(() {
        passwordError = errorMessage;
      });
    } else {
      setState(() {
        emailError = errorMessage;
      });
    }
  }

  handleSubmit() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });
    String? errorMessage = await AuthService().signInWithEmailAndPassword(
        email: _userEmailController.text,
        password: _userPasswordController.text);
        if (errorMessage!=null) {
          handleError(errorMessage);
        }
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SizedBox(
          width: formWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Logintext(),
              FillerSpace(height: 30),
              EmailField(
                textEditingController: _userEmailController,
                error: emailError,
              ),
              PasswordField(
                textEditingController: _userPasswordController,
                error: passwordError,
              ),
              ForgotPasswordButton(),
              FillerSpace(height: 20),
              FormSubmitButton(
                  formKey: _formKey,
                  text: 'Log In',
                  callback: (handleSubmit)),
              FillerSpace(height: 20),
              OrDivider(
                width: formWidth,
              ),
              FillerSpace(height: 30),
              const FaceBookLogIn(),
              FillerSpace(height: 180),
              const Divider(
                thickness: .5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text('Sign Up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FaceBookLogIn extends StatelessWidget {
  const FaceBookLogIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.squareFacebook,
        color: Colors.white,
      ),
      label: const Text(
        'Log In with Facebook',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

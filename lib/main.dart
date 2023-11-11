import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'storybar.dart';
import 'appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
            )
                ),
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
      },
      initialRoute: '/login',
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('no user found');
      } else if (e.code == 'wrong-password') {
        print('wrong password');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  final String title = 'Instaclone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox.expand(
          child: Stack(
            children: [Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.blue,
                    Colors.purple,
                    Color.fromARGB(255, 168, 44, 75),
                    Colors.orange
                  ]))),
               Positioned(
                top: 150,
                left: 10,
                right: 10,
                child: LoginForm()
                ),
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
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
      child: Column(
       children: [
         const Logintext(),
         EmailField(textEditingController: _userEmailController),
         PasswordField(textEditingController: _userPasswordController),
         ForgotPasswordButton(),
         ElevatedButton(
          onPressed: (){},
          child:Text('Login')
          )

       ],
                ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(vertical: 5),
     width: 320,
      child: Align(
       alignment: Alignment(.8,.9),
       child: GestureDetector(
         onTap: () {
           Navigator.pushNamed(context, '/home');
         },
         child: Text(
           'Forgot password?',
           style: Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.white),
         ),
       ),
      ),
    );
  }
}

class EmailField extends FormField {
  EmailField({super.key, required TextEditingController textEditingController})
    :super(textEditingController: textEditingController, hintText: 'Username');
}

class PasswordField extends FormField {
  PasswordField({super.key, required TextEditingController textEditingController})
    :super(textEditingController: textEditingController, hintText: 'Password');
}

class FormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  const FormField({
    super.key,
    required this.textEditingController,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: 320,
      height: 50,
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        ),
      ),
    );
  }
}


class Logintext extends StatelessWidget {
  const Logintext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'Instaclone',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final String title = 'Instaclone';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[HomePageAppBar(title: title), StoryBar()]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

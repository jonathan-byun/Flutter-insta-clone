import "package:flutter/material.dart";
import "package:flutter_1/email_and_pass.dart";
import "package:flutter_1/resources/auth.dart";
import 'package:flutter_1/pages/signup.dart';
import "package:flutter_1/text_and_space.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

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
  bool isLoading = false;
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

  void navigateToSignup() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  handleSubmit() async {
    setState(() {
      emailError = null;
      passwordError = null;
      isLoading = true;
    });
    String? errorMessage = await AuthService().signInWithEmailAndPassword(
        email: _userEmailController.text,
        password: _userPasswordController.text);
    if (errorMessage != null || errorMessage != 'Success') {
      handleError(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Logintext(),
              SizedBox(height: 30),
              TextInputField(
                  textEditingController: _userEmailController,
                  isPassword: false,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress),
              TextInputField(
                textEditingController: _userPasswordController,
                error: passwordError,
                isPassword: true,
                hintText: 'Password',
                keyboardType: TextInputType.text,
              ),
              ForgotPasswordButton(),
              SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FormSubmitButton(
                      formKey: _formKey,
                      text: 'Log In',
                      callback: (handleSubmit)),
              SizedBox(height: 20),
              OrDivider(
                width: formWidth,
              ),
              SizedBox(height: 30),
              const FaceBookLogIn(),
              SizedBox(height: 180),
              const Divider(
                thickness: .5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: navigateToSignup,
                      child: Text('Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold)))
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

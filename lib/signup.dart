import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_1/resources/auth.dart';
import 'package:flutter_1/email_and_pass.dart';
import 'text_and_space.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: (Stack(
          children: [const GradientBackdrop(), SignUpForm()],
        )),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final double formWidth = 320;
  final _signUpKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  String? emailError;
  String? passwordError;

  void handleError(errorMessage) {
    if (errorMessage.toLowerCase().contains('password')) {
      setState(() {
        passwordError = errorMessage;
      });
    } else {
      setState(() {
        emailError = errorMessage;
      });
    }
  }

  void registerUser() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });
    String? errorMessage = await AuthService().createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text
    );
    if (errorMessage != null) {
      handleError(errorMessage.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Center(
        child: SizedBox(
          width: formWidth,
          child: Column(
            children: [
              const Logintext(),
              const FillerSpace(height: 30),
              TextInputField(
                textEditingController: _emailController,
                isPassword: false,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                error: emailError,
              ),
              TextInputField(textEditingController: _usernameController, isPassword: false, hintText: 'Username', keyboardType: TextInputType.text),
              TextInputField(
                textEditingController: _passwordController,
                error: passwordError,
                isPassword: true,
                hintText: 'Password',
                keyboardType: TextInputType.text,
              ),
              FormSubmitButton(
                  formKey: _signUpKey, text: 'Sign Up', callback: registerUser)
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required String signupError,
  }) : _signupError = signupError;

  final String _signupError;

  @override
  Widget build(BuildContext context) {
    return Text(
      _signupError,
      style: TextStyle(color: Colors.red),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        alignment: Alignment(.8, .9),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Text(
            'Forgot password?',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController textEditingController;
  const EmailField(
      {super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            validator: (value) {
              if (value==null|| value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController textEditingController;
  const PasswordField(
      {super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      ),
    );
  }
}

class FormSubmitButton extends StatelessWidget {
  final String text;
  final AsyncCallback callback;
  const FormSubmitButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.text,
    required this.callback
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            fixedSize: Size(320, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: callback,
        // () {
        //   if (_formKey.currentState!.validate()) {callback;}
        // },
        child: Text(text));
  }
}
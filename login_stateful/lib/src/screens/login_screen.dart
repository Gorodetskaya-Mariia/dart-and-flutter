import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              emailField(),
              passwordField(),
              Container(margin: EdgeInsets.only(bottom: 25.0)),
              sumbitButton(),
            ],
          )),
    );
  }

  Widget emailField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: 'Email Address', hintText: 'you@example.com'),
        validator: (String value) {
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
        });
  }

  Widget passwordField() {
    return TextFormField(
        obscureText: true,
        decoration:
            InputDecoration(labelText: 'Password', hintText: 'Password'),
        validator: (String value) {
          if (value.length <= 5) {
            return 'Password must be at least 6 characters';
          }
        });
  }

  Widget sumbitButton() {
    return RaisedButton(
      child: Text('Submit'),
      color: Colors.blue[200],
      onPressed: () {
        formKey.currentState.validate();
      },
    );
  }
}

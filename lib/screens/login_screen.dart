import 'package:flutter/material.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'chat_screen.dart';
import 'package:chatapp/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const String id = "loginScreen";
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            //---------email textfield----------
            TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                )),
            SizedBox(
              height: 8.0,
            ),
            //---------password textfield----------
            TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                )),
            SizedBox(
              height: 24.0,
            ),
            //--------------------
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () {
                //Implement registration functionality.
              },
            ),
            //--------------------
          ],
        ),
      ),
    );
  }
}

import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  static const String id = "registrationScreen";
  _RegistrationScreenState createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            //-------------Register BUTTON----------
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressed: () {
                //Implement registration functionality.
              },
            ),
            //------------------
          ],
        ),
      ),
    );
  }
}

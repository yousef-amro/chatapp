import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const String id = "loginScreen";
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  )),
              SizedBox(
                height: 8.0,
              ),
              //---------password textfield----------
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
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
                onPressed: () async {
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    final user =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                    Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              //--------------------
            ],
          ),
        ),
      ),
    );
  }
}

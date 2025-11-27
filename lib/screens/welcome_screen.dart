import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  static const String id = "welcomeScreen";
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(milliseconds: 150),
                    ),
                  ],
                  totalRepeatCount: 1,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            //-------------LOGIN BUTTON----------
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Log in',
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.id);
              },
            ),
            //------------Register BUTTON---------
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

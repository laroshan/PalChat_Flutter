import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/roundedbutton.dart';
class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    controller.forward();
    animation= ColorTween(begin: Colors.blueGrey,end:Color.fromARGB(100,0, 151, 134)).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    @override
    void dispose() {
      super.dispose();
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/friends.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo.png'),
                        height: controller.value * 100,
                      ),
                    ),
                  ),
                  ColorizeAnimatedTextKit(
                    text:['Pal Chat'],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      fontFamily:'widow',

                    ),
                    colors:[
                      Colors.white,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton("Login",Colors.lightBlueAccent,(){
                Navigator.pushNamed(context,LoginScreen.id);
              }),

              RoundedButton("Register",Colors.blueAccent,(){
                Navigator.pushNamed(context,RegistrationScreen.id);
              }),

            ],
          ),
        ),
      ),
    );
  }
}


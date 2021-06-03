import 'package:flutter/material.dart';
import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {

  static String id="login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool spinner=false;
  String email;
  String password;
  final _auth= FirebaseAuth.instance;
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
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email=value;
                  },
                  decoration: kTextFieldDecorations.copyWith(hintText: "Enter your email")
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password=value;
                  },
                  decoration: kTextFieldDecorations.copyWith(hintText: "Enter your password")
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton("Log in",Colors.lightBlueAccent,()async{
                  setState(() {
                    spinner=false;
                  });
                  try{
                    final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinner=false;
                    });

                  }
                  catch(e){
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "Invalid credentials, Please try again",
                      //desc: "Login failed, Try again",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "COOL",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                    setState(() {
                      spinner=false;
                    });
                  }


                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {

  static String id="registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner=false;
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
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
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
            password=value;
                  },
                  decoration: kTextFieldDecorations.copyWith(hintText: "Enter your password")
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton("Register",Colors.blueAccent,()async{
                  setState(() {
                    spinner=true;
                  });
                  try{
                    final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser!=null)
                      {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    setState(() {
                      spinner=false;
                    });
                  }
                  catch(e)
                  {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Registration Failed",
                      desc: "Password must be greater than 6 characters",
                     // desc: "Password must be greater than 6 characters",
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

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

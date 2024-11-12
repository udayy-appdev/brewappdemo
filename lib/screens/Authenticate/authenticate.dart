import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo_app/screens/Authenticate/signin.dart';
import 'package:flutter_firebase_demo_app/screens/Authenticate/register.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;

  void toggleView(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return SignIN(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}

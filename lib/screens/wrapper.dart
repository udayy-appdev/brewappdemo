import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/screens/Authenticate/authenticate.dart';
import 'package:flutter_firebase_demo_app/screens/Home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_demo_app/screens/Home/homepage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final UserDetails? user = Provider.of<UserDetails?>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }
    else {
      return Homepage();
      print('hello');
    }
  }
}

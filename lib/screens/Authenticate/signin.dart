import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:flutter_firebase_demo_app/shared/decoration.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key, this.toggleView});
  final Function? toggleView;
  //SignIN({this.toggleView});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  late String email;
  late String password;
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Sign In',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [TextButton.icon(onPressed: (){
          widget.toggleView!();
        },
          icon: Icon(Icons.person),
          label: Text('Register'),
      ),],
      ),
      
      body: Padding(
          padding: EdgeInsets.all(45.0),
      child: Form(
        key: _formkey,
        child: Column(

          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textBoxDecoration.copyWith(hintText: 'Email'),
              validator: (value) => value!.isEmpty? 'Enter Email' : null,
              onChanged: (value){
                setState(() {
                  email = value;
                });
              } ,
              obscureText: false,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textBoxDecoration.copyWith(hintText: 'Password'),
              validator: (value) => (value!.length)<6? 'min 6 chars' : null,
              onChanged: (value){
                  password = value;
              } ,
              obscureText: true,
            ),
            SizedBox(height: 30.0),
            ElevatedButton(onPressed: () async{
              if(_formkey.currentState!.validate()) {
              dynamic result = await _auth.signInWithEmail(email, password);
              if(result==null){
                print('Enter Valid Email and Password');
                setState(() {
                  error = 'Enter Valid Email and Password';

                });
              }
              }
            },
                child: Text('Sign IN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
            )
            ),
            SizedBox(height: 15,),
            Text(error),
          ],
        ),
      ),)
      
    );
  }
}

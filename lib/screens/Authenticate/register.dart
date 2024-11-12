import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:flutter_firebase_demo_app/shared/decoration.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.toggleView});
  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  late String email;
  late String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text('Register',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: [
            TextButton.icon(onPressed: (){
              widget.toggleView!();
            },
                icon: Icon(Icons.person),
            label: Text('Sign IN'),),
          ],
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
                    email = value;
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
                  if(_formkey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmail(email, password);
                    if(result == null){
    print('Enter Valid Email and Password');
    setState(() {
    error = 'Enter Valid Email and Password';

    }
    );}
                  }
                  //widget.toggleView!();
                },
                    child: Text('Register',
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

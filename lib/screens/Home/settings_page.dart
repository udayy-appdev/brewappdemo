import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/screens/Home/brew_list.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo_app/services/DatabaseService.dart';
import 'package:flutter_firebase_demo_app/shared/decoration.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_demo_app/models/brew.dart';
import 'package:flutter_firebase_demo_app/services/loading.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> sugars = ['0','1','2','3','4','5'];
  String sugarvalue = '0';
  String namevalue = '';
  late int strengthvalue = 100;
  final _formkey = GlobalKey<FormState>();
  late Future<void> _initialLoadFuture;

  @override
  void initState() {
    super.initState();
    // Store the Future in a variable so it only triggers once
    _initialLoadFuture = Future.delayed(Duration(seconds: 1));
  }


  @override
  Widget build(BuildContext context) {
    final UserDetails? user = Provider.of<UserDetails?>(context);
    return StreamBuilder<UserBrewData>(
      stream: Databaseservice(uid: user?.uid).userData,
      builder: (context,snapshot){
        UserBrewData? userbrewdata = snapshot.data;
        return FutureBuilder(
        future: _initialLoadFuture, // Delay for 1 second
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingWidget();
        } else {
        // Show the main content after delay
        return Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                TextFormField(
                  initialValue: (userbrewdata!.name).toString(),
                  validator: (val) => val!.isEmpty? 'Enter Name' : null,
                  onChanged: (val) {
                    //setState(() {
                    namevalue = val;
                    //}),
                  },
                  decoration: textBoxDecoration.copyWith(hintText: 'Edit Name'),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                    value: userbrewdata!.sugars?? sugarvalue,
                    decoration: textBoxDecoration,
                    items: sugars.map((s){
                      return DropdownMenuItem(
                          value: s,
                          child: Text('$s Sugars'));
                    }).toList(),
                    onChanged: (val) {
                      //setState(() {
                      sugarvalue = val!;
                      //});
                    }
                ),
                SizedBox(height: 20,),
                Slider(
                    value: strengthvalue==100 ? (userbrewdata.strength).toDouble() : strengthvalue.toDouble(),
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    activeColor: Colors.brown[strengthvalue],
                    inactiveColor: Colors.brown[strengthvalue],
                    onChanged: (val) => setState(() {
                      strengthvalue = val.toInt();
                    })
                ),
                SizedBox(height: 50,),

                ElevatedButton(onPressed: () async{
                  if(_formkey.currentState!.validate()){
                    await Databaseservice(uid: user?.uid).updateUserData(
                        sugarvalue=='0'? userbrewdata.sugars : sugarvalue,
                        namevalue.isEmpty? userbrewdata.name : namevalue,
                        strengthvalue==100? userbrewdata.strength : strengthvalue);
                  };
                  Navigator.pop(context);

                },
                    child: Text('UPDATE'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[200])
                )
              ],
            ),
          ),
        );
        }
        },
        );
      }
    );
  }
}

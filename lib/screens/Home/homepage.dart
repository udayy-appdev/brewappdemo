import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/screens/Home/brew_list.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo_app/services/DatabaseService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_demo_app/models/brew.dart';
import 'package:flutter_firebase_demo_app/screens/Home/settings_page.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void showBottomPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: SettingsPage(),
        );
      });
    }

    return StreamProvider<List<Brew>?>.value(
      value: Databaseservice().brews,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Brewpub'),
          actions: <Widget>[
            TextButton.icon(onPressed: () async{
              await _auth.signOut();
            },
                icon: Icon(Icons.person),
            label: Text('logout'),
            ),
            TextButton.icon(onPressed: (){
              showBottomPanel();
                  },
                icon: Icon(Icons.settings),
              label: Text('settings'),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}

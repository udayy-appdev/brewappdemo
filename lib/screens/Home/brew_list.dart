import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/models/brew.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo_app/services/DatabaseService.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    //print('brews entered');

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        final brew = brews[index];

        // Define a color based on the strength (you can adjust the color shades as needed)
        //Color strengthColor = Color.fromRGBO(139, 69, 19, brew.strength);

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown[brew.strength],
              radius: 25.0,
            ),
            title: Text(brew.name),
            subtitle: Text('Sugars: ${brew.sugars}'),
          ),
        );
      },
    );
  }
}




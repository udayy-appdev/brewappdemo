import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo_app/models/brew.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';

class Databaseservice {

  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection('brews');
  final String? uid;

  Databaseservice({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }


  List<Brew> _brewlistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        sugars: doc.get('sugars') ?? '0',
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }

  UserBrewData _userBrewDataFromSnapshot(DocumentSnapshot snapshot){
    return UserBrewData(uid: uid!, name: snapshot.get('name'), sugars: snapshot.get('sugars'), strength: snapshot.get('strength'));

  }



//Stream Snapshot

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewlistFromSnapshot);
  }


  Stream<UserBrewData> get userData {
    return brewCollection.doc(uid).snapshots()
        .map(_userBrewDataFromSnapshot);
  }

}
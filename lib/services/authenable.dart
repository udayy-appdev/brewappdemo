import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/services/DatabaseService.dart';
class AuthService {

  //Sign Anon
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserDetails? _userFromFirebaseUser(User? user) {
    return user != null ? UserDetails(uid: user.uid): null;
  }

  Stream<UserDetails?> get user{
    return _auth.authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user as User);
      //return result;
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  //Sign EMail
  Future signInWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(user as User);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  //Register

  Future registerWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await Databaseservice(uid: user?.uid).updateUserData('0', 'new customer', 100);
      return _userFromFirebaseUser(user as User);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  //Sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e);
      return null;
    }

}


}
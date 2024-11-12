import 'package:flutter/material.dart';
import 'package:collection/wrappers.dart';
import 'package:flutter_firebase_demo_app/models/usermodel.dart';
import 'package:flutter_firebase_demo_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo_app/services/authenable.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensures all bindings are initialized before running the app
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(StreamProvider<UserDetails?>.value(
    initialData:  null,
    value: AuthService().user,
    child: MaterialApp(
        home: Wrapper(),
    ),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('home'),
    );
  }

}
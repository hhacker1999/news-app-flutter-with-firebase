import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/screens/notes_page.dart';
import 'package:notes_app/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        theme: ThemeData.dark(),
        home: NotesPage(),
      );
    } else {
      return MaterialApp(
        theme: ThemeData.dark(),
        home: SignIn(),
      );
    }
  }
}

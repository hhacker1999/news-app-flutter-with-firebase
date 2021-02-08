import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes_app/services/firestore_function.dart';

class FireBaseAuth {
  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth auth = FirebaseAuth.instance;

      FirestoreFunctions()
          .addUser(auth.currentUser.uid, auth.currentUser.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  String currentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser.uid;
    return user;
  }
}

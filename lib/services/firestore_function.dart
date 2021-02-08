import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notes_app/services/firebase_auth.dart';

class FirestoreFunctions {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  Future<void> addUser(String uid, String email) {
    return users
        .add({
          'uid': uid,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNotes(
    String title,
    String content,
    DateTime savetime,
    String uid,
  ) {
    return notes
        .add({
          'title': title,
          'content': content,
          'save date': savetime,
          'last edited': savetime,
          'uid': uid,
        })
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add notes: $error"));
  }

  Future<void> updateNotes(
    String title,
    String content,
    DateTime savetime,
    DateTime lastsaved,
    String uid,
    String docid,
  ) {
    return notes
        .doc(docid)
        .update({
          'title': title,
          'content': content,
          'save date': savetime,
          'last saved': lastsaved,
          'uid': uid,
        })
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add notes: $error"));
  }

  Future<void> deleteNote(String docid) {
    return notes.doc(docid).delete();
  }

  Stream<QuerySnapshot> notesStream() {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('uid', isEqualTo: FireBaseAuth().currentUser())
        .orderBy('save date', descending: true)
        .snapshots();
  }
}

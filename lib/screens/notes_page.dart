import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/screens/note_create.dart';
import 'package:notes_app/screens/note_editor.dart';
import 'package:notes_app/screens/sign_in_page.dart';
import 'package:notes_app/services/firebase_auth.dart';
import 'package:notes_app/services/firestore_function.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harsh Notes'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Container(height: 500, child: NoteShow())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () async {
                    await FireBaseAuth().signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Icon(
                    Icons.logout,
                    size: 35.0,
                  )),
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoteCreater()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoteShow extends StatefulWidget {
  @override
  _NoteShowState createState() => _NoteShowState();
}

class _NoteShowState extends State<NoteShow> {
  @override
  void initState() {
    noteStream();
    super.initState();
  }

  Stream<QuerySnapshot> noteStream() {
    return FirestoreFunctions().notesStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: noteStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot note = snapshot.data.docs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteEditor(
                                editabletitle: note['title'],
                                editablecontent: note['content'],
                                docid: note.id,
                              )),
                    );
                  },
                  onLongPress: () {
                    buildAlertDialog(note.id, context);
                  },
                  onDoubleTap: () {
                    buildAlertDialog(note.id, context);
                  },
                  child: NoteCard(
                    title: note['title'],
                    content: note['content'],
                    savetime: note['save date'].toDate(),
                  ),
                );
              });
        }
      },
    );
  }

  Widget buildAlertDialog(String note, BuildContext context) {
    return AlertDialog(
      title: Text('Are You sure you want to delete this note'),
      content: Text('Your Note will be deleted'),
      elevation: 8.0,
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await FirestoreFunctions().deleteNote(note);
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
      ],
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime savetime;

  NoteCard({
    this.title,
    this.content,
    this.savetime,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 8.0,
      color: Colors.teal[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text('Saved on $savetime')
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

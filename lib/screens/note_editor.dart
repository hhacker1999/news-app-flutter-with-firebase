import 'package:flutter/material.dart';

import 'package:notes_app/screens/notes_page.dart';
import 'package:notes_app/services/firebase_auth.dart';
import 'package:notes_app/services/firestore_function.dart';

class NoteEditor extends StatefulWidget {
  final String editabletitle;
  final String editablecontent;
  final DateTime oldtime;
  final String docid;
  NoteEditor(
      {this.editablecontent, this.editabletitle, this.oldtime, this.docid});
  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  DateTime savetime;

  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    titlecontroller.text = widget.editabletitle;
    contentcontroller.text = widget.editablecontent;
    super.initState();
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    contentcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harsh Notes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: titlecontroller,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter title',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: TextFormField(
                    controller: contentcontroller,
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Content',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.attachment,
                    size: 40.0,
                  ),
                  RaisedButton(
                    color: Colors.blue[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed: () async {
                      await FirestoreFunctions().updateNotes(
                          titlecontroller.text,
                          contentcontroller.text,
                          dateTime,
                          savetime,
                          FireBaseAuth().currentUser(),
                          widget.docid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotesPage()),
                      );
                    },
                    child: Text(
                      'save',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notes_app/components/fields.dart';

import 'package:notes_app/screens/notes_page.dart';
import 'package:notes_app/screens/sign_up_page.dart';
import 'package:notes_app/services/firebase_auth.dart';

class SignIn extends StatelessWidget {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harsh News'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Fields(
            controller: emailcontroller,
            title: 'Enter Email',
          ),
          SizedBox(
            height: 20.0,
          ),
          Fields(
            controller: passwordcontroller,
            title: 'Enter Password',
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            elevation: 8.0,
            color: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.green)),
            onPressed: () async {
              String email = emailcontroller.text;
              String password = passwordcontroller.text;
              await FireBaseAuth().signIn(email, password);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotesPage()),
              );
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.blue)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Text(
                  'Sign Up ',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}

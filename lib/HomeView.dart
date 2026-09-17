import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homeview extends StatelessWidget{

  void funClickLogout(BuildContext context){
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, "/LoginView");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: .center,
        children: [
          Text("Homeview"),
          TextButton(onPressed:()=> funClickLogout(context),
                     child: Text("Logout"))
        ],
      )
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homeview extends StatefulWidget {
  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  void initState() {
    super.initState();
    comprobarPerfil();
  }

  void comprobarPerfil() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Perfiles").doc(user.uid).get();

      if (!doc.exists) {
        // Si no hay perfil, le obligamos a ir a ProfileView
        if (mounted) {
          Navigator.popAndPushNamed(context, "/ProfileView");
        }
      }
    }
  }

  void funClickLogout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, "/LoginView");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BIENVENIDO A HOME", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => funClickLogout(context),
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}

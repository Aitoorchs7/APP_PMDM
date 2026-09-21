import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Perfil.dart';

class Onboardingview extends StatefulWidget{
  const Onboardingview({super.key});

  @override
  State<Onboardingview> createState() => _Onboardingview();
}

class _Onboardingview extends State<Onboardingview> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  int _iProgress = 0;

  void initState() {
    super.initState();
    cargarRecursos();
  }

  void cargarRecursos() async {
    await recurso1();
    setState(() {
      _iProgress = 20;
    });
    await recurso2();
    setState(() {
      _iProgress = 70;
    });
    await recurso3();
    setState(() {
      _iProgress = 100;
    });

    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.popAndPushNamed(context, "/LoginView");
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final docRef = db.collection("Perfiles").doc(uid).withConverter(
          fromFirestore: Perfil.fromFirestore,
          toFirestore: (perfil, _) => perfil.toFirestore(),
        );

        final docSnap = await docRef.get();
        Perfil? perfil = docSnap.data();

        if (perfil == null) {
          // SI EXISTE: Vamos al Home
          Navigator.popAndPushNamed(context, "/ProfileView");
        } else {
          // NO EXISTE PERFIL: Vamos al Profileview
          Navigator.popAndPushNamed(context, "/HomeView");
        }
    }

  }

  Future<void> recurso1() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> recurso2() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> recurso3() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.network(
                "https://imgs.search.brave.com/Ea9Tj2Xx7q7exKAw4kZNcN52k3CmnobUMxMIFjLIy0U/rs:fit:0:180:1:0/g:ce/aHR0cHM6Ly9tZWdh/Y2F0c3R1ZGlvcy5j/b20vY2RuL3Nob3Av/YXJ0aWNsZXMvQWxt/b3N0SGVyb185MDBf/MjUzLTgyNzEyMzku/cG5nP3Y9MTc2MzAx/OTUyMyZ3aWR0aD0x/OTIw"),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: LinearProgressIndicator(value: _iProgress/100,)
            ),
            Text("$_iProgress%")
          ],
        ),
      ),
    );
  }
}


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fbobject/Perfil.dart';

class Profileview extends StatelessWidget {
  TextEditingController nombreController = new TextEditingController();
  TextEditingController edadController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void funConfirmar(BuildContext context) {
    if (nombreController.text.isNotEmpty && edadController.text.isNotEmpty) {
      final perfilesCollection = db.collection("Perfiles");

      // Usamos .parse() para convertir los textos a sus tipos originales
      final perfil = new Perfil(
        uid: FirebaseAuth.instance.currentUser!.uid,
        nombre: nombreController.text,
        edad: int.parse(edadController.text),
        altura: double.parse(alturaController.text),
        peso: double.parse(pesoController.text),
      );

      perfilesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(perfil.toFirestore())
          .then((value) {
        Navigator.popAndPushNamed(context, "/HomeView");
      });
    }
  }

  void funSalir() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completar Perfil")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(hintText: "Nombre completo"),
            ),
            TextField(
              controller: edadController,
              decoration: InputDecoration(hintText: "Edad"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: alturaController,
              decoration: InputDecoration(hintText: "Altura (cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: pesoController,
              decoration: InputDecoration(hintText: "Peso (kg)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => funConfirmar(context),
              child: Text("Confirmar"),
            ),
            TextButton(
              onPressed: funSalir,
              child: Text("Salir"),
            )
          ],
        ),
      ),
    );
  }
}

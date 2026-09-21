

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Profileview extends StatelessWidget{
  TextEditingController nombreController = new TextEditingController();
  TextEditingController edadController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;


  void funConfirmar(BuildContext context){
    if(nombreController.text.isNotEmpty && edadController.text.isNotEmpty) {
      final users = db.collection("Perfiles");
      final user = <String, dynamic>{
        "nombre": nombreController.text,
        "edad": edadController.text,
        "altura": alturaController.text,
        "peso": pesoController.text,
        // se pueden poner mas campos
      };
      users.doc(FirebaseAuth.instance.currentUser!.uid).set(user).then((value) {
        Navigator.popAndPushNamed(context, "/HomeView");
      });
    }
  }
  void funSalir(){
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
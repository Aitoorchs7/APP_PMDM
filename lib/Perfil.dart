import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  String? nombre;
  String? edad;
  String? altura;
  String? peso;

  Perfil({
    this.nombre,
    this.edad,
    this.altura,
    this.peso
  });

  factory Perfil.fromFirestore(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
  SnapshotOptions? options,
  ) {
  final data = snapshot.data();
  return Perfil(
  nombre: data?['nombre'],
  edad: data?['edad'],
  altura: data?['altura'],
  peso: data?['peso'],
  );
  }

  Map<String, dynamic> toFirestore() {
  return {
  if (nombre != null) 'nombre': nombre,
  if (edad != null) 'edad': edad,
  if (altura != null) 'altura': altura,
  if (peso != null) 'peso': peso,
  };

  }
}


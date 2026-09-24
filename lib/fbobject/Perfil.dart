import 'package:cloud_firestore/cloud_firestore.dart';
import 'Mensaje.dart';

class Perfil {
  String? uid;
  String? nombre;
  int? edad;
  double? altura;
  double? peso;
  List<Mensaje> mensajes=List.empty();

  Perfil({this.uid, this.nombre, this.edad, this.altura,this.peso});

  factory Perfil.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Perfil(
      uid: snapshot.id,
      nombre: data?['nombre'] as String?,
      edad: (data?['edad'] as num?)?.toInt(),
      altura: (data?['altura'] as num?)?.toDouble(),
      peso: (data?['peso'] as num?)?.toDouble(),
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

  Future<void> descargarMensajes() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    var timestamp = Timestamp.fromDate(DateTime.utc(2026,01,01));

    final docRef = db.collection("Perfiles/"+uid!+"/Mensajes")
        .where("leido",isEqualTo: false).limit(20)
        .withConverter(
        fromFirestore: Mensaje.fromFirestore,
        toFirestore: (Mensaje mensaje, _) => mensaje.toFirestore());

    final querySnapshot=await docRef.get();

    for(var docSnapshot in querySnapshot.docs){
      print('${docSnapshot.id} => ${docSnapshot.data()}');
    }
  }
}

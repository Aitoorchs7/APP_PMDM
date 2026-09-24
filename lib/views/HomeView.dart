import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Dataholder.dart';

class Homeview extends StatefulWidget {
  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  String sNombre=Dataholder.instance.perfilUsuario.nombre!;
  late BuildContext miContext;
  TextEditingController nombreController = new TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  int _bottomNavIndex = 0;
  List<IconData> iconList=[Icons.eighteen_up_rating, Icons.home, Icons.settings, Icons.inbox, Icons.person];
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

  void clickActualizarNombre(){
    setState(() {
      sNombre=nombreController.text;
    });
    Dataholder.instance.perfilUsuario.nombre=sNombre;
    db.collection("Perfiles")
        .doc(Dataholder.instance.perfilUsuario.uid)
        .set(Dataholder.instance.perfilUsuario.toFirestore());

  }

  void clickBuscar() {
    // TODO: aqui ira la busqueda
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Buscar")),
    );
  }

  void funClickLogout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, "/LoginView");
  }

  @override
  Widget build(BuildContext context) {
    miContext=context;
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String valor) {
              switch (valor) {
                case "buscar":
                  clickBuscar();
                  break;
                case "perfil":
                  Navigator.pushNamed(context, "/ProfileView");
                  break;
                case "logout":
                  funClickLogout(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: "buscar",
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Buscar"),
                ),
              ),
              PopupMenuItem<String>(
                value: "perfil",
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Perfil"),
                ),
              ),
              PopupMenuItem<String>(
                value: "logout",
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Salir"),
                ),
              ),
            ],
          ),
        ],
      ),
      body:Container(
        color: Color.fromARGB(255, 146, 183 , 123),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BIENVENIDO A HOME" + sNombre, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextButton(onPressed: () => funClickLogout(context),
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
            TextField(controller: nombreController, decoration: InputDecoration(hintText: "Nombre"),),
            TextButton(onPressed: clickActualizarNombre, child: Text("Guardar")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
      )
    );
  }
}

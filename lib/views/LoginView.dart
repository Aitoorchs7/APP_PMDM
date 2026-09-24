import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginview extends StatelessWidget{
  late BuildContext miContext;
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void funClickLogin() async{
    String usuario=userController.text;
    String pass=passwordController.text;
    print("---->>>>>>>> LOGIN PRESIONADO "+usuario+"   "+pass);

    if(usuario=="" || pass==""){
      mostrarError("Debes rellenar usuario y contraseña.");
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usuario,
          password: pass
      );
      // Si llega aqui es que el usuario y la contraseña son correctos en Firebase
      print("---->>>>>>>> LOGIN CORRECTO "+credential.user!.email!);
      Navigator.popAndPushNamed(miContext, "/HomeView");
    } on FirebaseAuthException catch (e) {
      // Si entra aqui NO se deja pasar: no se navega a HomeView
      print("---->>>>>>>> LOGIN INCORRECTO "+e.code);
      if (e.code == 'user-not-found') {
        mostrarError("No existe ningun usuario con ese email.");
      } else if (e.code == 'wrong-password') {
        mostrarError("Contraseña incorrecta.");
      } else if (e.code == 'invalid-email') {
        mostrarError("El email no es valido.");
      } else {
        mostrarError("Usuario o contraseña incorrectos.");
      }
    }

  }

  void mostrarError(String mensaje){
    ScaffoldMessenger.of(miContext).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red,),
    );
  }

  void funClickRegistro(){
    print("---->>>>>>>> REGISTRO PRESIONADO");
    Navigator.pushNamed(miContext, "/RegisterView");
  }

  @override
  Widget build(BuildContext context) {
    miContext=context;
    TextStyle tsEstiloTexto=new TextStyle(fontSize: 30,backgroundColor:Colors.red);

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(title:new Text("MI APP DAM2627"),),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Text("LOGIN",style: tsEstiloTexto,),
          TextField(controller: userController,decoration: InputDecoration(hintText: "Usuario"),),
          TextField(controller:passwordController,decoration: InputDecoration(hintText: "Contraseña"),obscureText: true,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: funClickLogin, child: Text("Login")),
              TextButton(onPressed: funClickRegistro, child: Text("Registrarse"))
            ],
          )
        ],
      ),
    );
  }

}
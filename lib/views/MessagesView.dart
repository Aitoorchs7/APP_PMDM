import 'package:flutter/material.dart';

import '../Dataholder.dart';
import '../ins.lib/Insbotbarstyle1.dart';

class Messagesview extends StatefulWidget{
  @override
  State<Messagesview> createState() => _MessagesviewState();
}

class _MessagesviewState extends State<Messagesview> {

  @override
  void initState() {
    super.initState();
    Dataholder.instance.iBotBarIndex=2;
    Dataholder.instance.sMessagesBadgeText="";

  }
  Widget? creadorDeItems(BuildContext context, int indice) {

    return Container(
      color: Color.fromARGB(255, 146, 183 , 123),
      height: 50,
      child: Text("Mensaje " + indice.toString()),
    );
  }

  Widget crearGrid(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: creadorDeItems,
    );

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: creadorDeItems,
        ),
        bottomNavigationBar: Insbotbarstyle1(
            blBadge1: Dataholder.instance.blNotificacionesBadge,
            sBadge2: Dataholder.instance.sMessagesBadgeText,
            iBarIndex: Dataholder.instance.iBotBarIndex
        ),
      );
  }
}

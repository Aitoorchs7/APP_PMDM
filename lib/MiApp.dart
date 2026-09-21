
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_app/OnboardingView.dart';
import 'package:mi_app/ProfileView.dart';

import 'HomeView.dart';
import 'LoginView.dart';
import 'RegisterView.dart';

class Miapp extends StatelessWidget {
  double dbNumber=0.0;

  @override
  Widget build(BuildContext context) {

    String rutaInicial="/LoginView";
    if(FirebaseAuth.instance.currentUser!=null){
      rutaInicial="/HomeView";
    }

    return new MaterialApp(
      title: "MI APP 1",
      routes: {
        "/LoginView" : (context) =>  Loginview(),
        "/HomeView" : (context) =>  Homeview(),
        "/RegisterView" : (context) =>  Registerview(),
        "/Onboardingview" : (context) =>  Onboardingview(),
        "/ProfileView" : (context) =>  Profileview(),
      },
      initialRoute: "/Onboardingview",
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        body: CarouselView(
          scrollDirection: Axis.vertical,
          itemExtent: double.infinity,
          children: List<Widget>.generate(10, (int index) {
            return Center(child: Text('Item $index'));
          }),
        ),
      ),
    );

  }
*/

}
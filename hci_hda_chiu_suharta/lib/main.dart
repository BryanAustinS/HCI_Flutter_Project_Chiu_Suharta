import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/pages/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/pages/techniker_home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/technikerHome', //for login page
    routes: {
      '/technikerHome' : (context) => TechnikerHome(),
      '/kundeHome': (context) => KundeHome(), 
     
      // '/home' : (context) => Home(),
      // '/location':(context) => ChooseLocation(),
    }
  ));
}

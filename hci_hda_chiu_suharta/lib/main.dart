import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/pages/kunde_home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/kundeHome', //for login page
    routes: {
      '/kundeHome': (context) => KundeHome(), 
      // '/home' : (context) => Home(),
      // '/location':(context) => ChooseLocation(),
    }
  ));
}

import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/class/person.dart';

class Betreiber extends Person{

  Fahrrarzt? fahrrarzt;

  Betreiber(String id, String name) : super(id, name);

  int calculateEinnahme(){
    return 0;
  }
}
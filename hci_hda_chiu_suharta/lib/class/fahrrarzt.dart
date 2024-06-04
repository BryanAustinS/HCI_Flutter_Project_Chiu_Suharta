import 'package:hci_hda_chiu_suharta/class/buchung.dart';
import 'package:hci_hda_chiu_suharta/class/kunde.dart';
import 'package:hci_hda_chiu_suharta/class/sparepart.dart';
import 'package:hci_hda_chiu_suharta/class/techniker.dart';

class Fahrrarzt{
  List<Techniker>? alleTechniker;
  List<Buchung>? alleBuchungen;
  List<Kunde>? alleKunden;
  Map<Sparepart, int>? warehouse; //Fill this with json file
}
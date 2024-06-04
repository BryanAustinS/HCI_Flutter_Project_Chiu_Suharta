import 'package:hci_hda_chiu_suharta/class/person.dart';
import 'package:hci_hda_chiu_suharta/class/buchung.dart';


class Kunde extends Person{
  List<Buchung> kundeBuchungen;

  Kunde(String id, String name, this.kundeBuchungen) : super(id, name);
}
import 'package:hci_hda_chiu_suharta/class/person.dart';
import 'package:hci_hda_chiu_suharta/class/Booking.dart';


class Kunde extends Person{
  List<Booking> kundeBuchungen;

  Kunde(String id, String name, this.kundeBuchungen) : super(id, name);

    void reparaturBuchen() {
    // TODO: implement reparaturBuchen
  }

  void showTracking (String buchungId){

  }
  
}
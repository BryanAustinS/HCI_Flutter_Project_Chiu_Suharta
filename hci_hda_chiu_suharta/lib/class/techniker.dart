import 'package:hci_hda_chiu_suharta/class/person.dart';
import 'package:hci_hda_chiu_suharta/class/buchung.dart';


class Techniker extends Person{
  List<Buchung> technikerBuchungen;

  Techniker(String id, String name, this.technikerBuchungen) : super(id, name);

  void orderErsatzteile(){

  }

  void setStatus(){
    
  }

} 
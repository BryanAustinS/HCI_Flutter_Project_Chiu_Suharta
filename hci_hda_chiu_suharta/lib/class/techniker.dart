import 'package:hci_hda_chiu_suharta/class/person.dart';
import 'package:hci_hda_chiu_suharta/class/Booking.dart';


class Techniker extends Person{
  List<Booking> technikerBuchungen;

  Techniker(String id, String name, this.technikerBuchungen) : super(id, name);

  void orderErsatzteile(){

  }

  void setStatus(){
    
  }

} 
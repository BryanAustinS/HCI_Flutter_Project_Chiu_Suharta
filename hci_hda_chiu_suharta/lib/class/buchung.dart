import 'package:hci_hda_chiu_suharta/class/kunde.dart';
import 'package:hci_hda_chiu_suharta/class/techniker.dart';
import 'package:hci_hda_chiu_suharta/class/sparepart.dart';

class Buchung{
  Techniker? techniker;
  Kunde? kunde;
  String? id;
  List<Sparepart>? spareparts;
  int? price;
}
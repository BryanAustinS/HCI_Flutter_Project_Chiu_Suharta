import 'package:hci_hda_chiu_suharta/class/Booking.dart';
import 'package:hci_hda_chiu_suharta/class/kunde.dart';
import 'package:hci_hda_chiu_suharta/class/sparepart.dart'; // Import the Sparepart class
import 'package:hci_hda_chiu_suharta/class/techniker.dart';

class Fahrrarzt {
  List<Techniker>? alleTechniker;
  List<Booking>? alleBuchungen;
  List<Kunde>? alleKunden;

  Map<Sparepart, int>? warehouse = {
    //Komponente
    Sparepart(
      name: 'Brakes',
      buyPrice: 20, 
      sellPrice: 50 
    ): 10,
    Sparepart(
      name: 'Chains',
      buyPrice: 10,
      sellPrice: 20
    ): 10,
    Sparepart(
      name: 'Saddle',
      buyPrice: 5,
      sellPrice: 10
    ): 10,
    Sparepart(
      name: 'Tyres',
      buyPrice: 7,
      sellPrice: 15
    ): 10,
    Sparepart(
      name: 'Spokes',
      buyPrice: 5,
      sellPrice: 12
    ): 10,

    //Zubehoer
    Sparepart(
      name: 'Bike locks',
      buyPrice: 3,
      sellPrice: 10
    ): 10,
    Sparepart(
      name: 'Lights',
      buyPrice: 2,
      sellPrice: 7
    ): 10,
    Sparepart(
      name: 'Luggage racks',
      buyPrice: 12,
      sellPrice: 20
    ): 10,
    Sparepart(
      name: 'Bike pumps',
      buyPrice: 3,
      sellPrice: 10
    ): 10,
  };
}

class FahrrarztProvider {
  static final FahrrarztProvider _instance = FahrrarztProvider._internal();

  factory FahrrarztProvider() {
    return _instance;
  }

  FahrrarztProvider._internal();

  Fahrrarzt _fahrrarzt = Fahrrarzt();

  Fahrrarzt get fahrrarzt => _fahrrarzt;
}

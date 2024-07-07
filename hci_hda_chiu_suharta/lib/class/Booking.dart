import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_hda_chiu_suharta/class/kunde.dart';
import 'package:hci_hda_chiu_suharta/class/techniker.dart';
import 'package:hci_hda_chiu_suharta/class/sparepart.dart';

enum Status{
  PENDING,
  BESTATIGT,
  VERARBEITET,
  FERTIG
}

class Booking{
  Techniker? techniker;
  Kunde? kunde;
  String? id;
  List<Sparepart>? spareparts;
  int price = 0;
  Status status = Status.PENDING;
  String userId;

  Booking({
    required this.userId,
  });


  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      userId: map['userId'],
    );
  }

  Future addUserBooking(Map<String, dynamic> userInfoMap) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('booking').add(userInfoMap);
    return docRef.id;
  }

  Future<String?> fetchUserName() async {
    final userDoc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
    return userDoc.data()?['name'];
  }

  

}
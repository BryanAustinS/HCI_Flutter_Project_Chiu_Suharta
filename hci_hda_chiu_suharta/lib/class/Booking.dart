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
  Future<String> addUserBooking(Map<String, dynamic> userInfoMap) async {
  DocumentReference docRef = await FirebaseFirestore.instance.collection('booking').add(userInfoMap);

  String bookingId = docRef.id; // Retrieve the auto-generated ID

  DocumentReference docRef2 = FirebaseFirestore.instance.collection('allBookings').doc(bookingId);
  await docRef2.set(userInfoMap); // Set data with the same ID
  
  return bookingId; 
}


  Future<String?> fetchUserName() async {
    final userDoc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
    return userDoc.data()?['name'];
  }
}
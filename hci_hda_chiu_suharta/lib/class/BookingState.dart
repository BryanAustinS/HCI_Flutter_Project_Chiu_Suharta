import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Booking.dart';

class BookingState with ChangeNotifier{
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  BookingState(){
    fetchBooking();
  }

  void fetchBooking() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('booking').get();
    _bookings = querySnapshot.docs.map((doc) {
      final data = doc.data();
      if (data != null) {
        return Booking.fromMap(data as Map<String, dynamic>);
      } else {
        return null;
      }
    }).where((item) => item != null).toList().cast<Booking>();
    notifyListeners();
  }
}
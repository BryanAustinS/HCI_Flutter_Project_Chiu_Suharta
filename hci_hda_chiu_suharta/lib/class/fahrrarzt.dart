import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Booking.dart';
import 'kunde.dart';
import 'sparepart.dart';
import 'techniker.dart';

class Fahrrarzt {
  static final Sparepart brakes = Sparepart(name: 'Brakes', buyPrice: 20, sellPrice: 50);
  static final Sparepart chains = Sparepart(name: 'Chains', buyPrice: 10, sellPrice: 20);
  static final Sparepart saddle = Sparepart(name: 'Saddle', buyPrice: 5, sellPrice: 10);
  static final Sparepart tyres = Sparepart(name: 'Tyres', buyPrice: 7, sellPrice: 15);
  static final Sparepart spokes = Sparepart(name: 'Spokes', buyPrice: 5, sellPrice: 12);
  static final Sparepart bikeLocks = Sparepart(name: 'Bike locks', buyPrice: 3, sellPrice: 10);
  static final Sparepart lights = Sparepart(name: 'Lights', buyPrice: 2, sellPrice: 7);
  static final Sparepart luggageRacks = Sparepart(name: 'Luggage racks', buyPrice: 12, sellPrice: 20);
  static final Sparepart bikePumps = Sparepart(name: 'Bike pumps', buyPrice: 3, sellPrice: 10);

  List<Techniker>? alleTechniker;
  List<Booking>? alleBuchungen;
  List<Kunde>? alleKunden;

  Map<Sparepart, int>? warehouse = {
    brakes: 10,
    chains: 10,
    saddle: 10,
    tyres: 10,
    spokes: 10,
    bikeLocks: 10,
    lights: 10,
    luggageRacks: 10,
    bikePumps: 10,
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

  Future<void> updateWarehouseFromFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('stock').doc('BlQHxe7XnhytZnMzDxNW').get();

    if (doc.exists) {
      final data = doc.data()!;
      _fahrrarzt.warehouse?.update(Fahrrarzt.brakes, (value) => data['Brakes']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.chains, (value) => data['Chains']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.saddle, (value) => data['Saddle']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.tyres, (value) => data['Tyres']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.spokes, (value) => data['Spokes']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.bikeLocks, (value) => data['Bike locks']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.lights, (value) => data['Lights']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.luggageRacks, (value) => data['Luggage racks']);
      _fahrrarzt.warehouse?.update(Fahrrarzt.bikePumps, (value) => data['Bike pumps']);
    }
  }
}

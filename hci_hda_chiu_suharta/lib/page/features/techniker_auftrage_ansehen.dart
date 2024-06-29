import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/class/sparepart.dart';
import 'package:lottie/lottie.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../theme/theme.dart';
import '../../localization/locales.dart';

class AuftrageAnsehen extends StatefulWidget {
  const AuftrageAnsehen({Key? key}) : super(key: key);

  @override
  State<AuftrageAnsehen> createState() => _AuftrageAnsehenState();
}

class _AuftrageAnsehenState extends State<AuftrageAnsehen> {
  @override
  Widget build(BuildContext context) {
    var bodyStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'InterRegular',
        );
    Color primaryColor = lightColorScheme.primary;
    Color bgColor = lightColorScheme.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'FAHRRARZT',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            letterSpacing: 2.0,
            color: bgColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Text(
            LocaleData.meineReparaturen.getString(context),
            style: const TextStyle(fontSize: 26, fontFamily: 'Montserrat'),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('booking').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }
                var myBookings = snapshot.data!.docs.where((booking) {
                  final data = booking.data() as Map<String, dynamic>;
                  return data.containsKey('chosen') &&
                      (data['chosen'] as bool? ?? false);
                }).toList();

                if (myBookings.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/no_my_booking.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: myBookings.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot booking = myBookings[index];
                    final data = booking.data() as Map<String, dynamic>;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFF7553F6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${booking['name']}', style: bodyStyle),
                          Text('Booking ID: ${booking.id}', style: bodyStyle),
                          Text('Price: ${booking['price']}', style: bodyStyle),
                          Text('Component: ${booking['komponente'].join(', ')}',
                              style: bodyStyle),
                          Text('Zubehor: ${booking['zubehoer'].join(', ')}',
                              style: bodyStyle),
                          Text('Status: ${booking['status']}',
                              style: bodyStyle),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      showDetailDialog(
                                          context, data, booking.id);
                                    },
                                    child: Text(
                                      LocaleData.showDetails.getString(context),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('booking')
                                          .doc(booking.id)
                                          .update({
                                        'status': 'finished',
                                      });
                                    },
                                    child: Text(
                                      LocaleData.fertig.getString(context),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(LocaleData.verfugbareBooking.getString(context),
              style: const TextStyle(
                fontSize: 26,
                fontFamily: 'Montserrat',
              )),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('booking').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }
                var availableBookings = snapshot.data!.docs.where((booking) {
                  final data = booking.data() as Map<String, dynamic>;
                  return !data.containsKey('chosen') ||
                      !(data['chosen'] as bool? ?? false);
                }).toList();

                if (availableBookings.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/no_available_booking.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: availableBookings.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot booking = availableBookings[index];
                    final data = booking.data() as Map<String, dynamic>;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFF7553F6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${data['name']}', style: bodyStyle),
                          Text('Booking ID: ${booking.id}', style: bodyStyle),
                          Text('Price: ${data['price']}', style: bodyStyle),
                          Text('Component: ${data['komponente'].join(', ')}',
                              style: bodyStyle),
                          Text('Zubehor: ${data['zubehoer'].join(', ')}',
                              style: bodyStyle),
                          Text('Status: ${data['status']}', style: bodyStyle),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(LocaleData.chooseBooking
                                            .getString(context)),
                                        content: Text(LocaleData
                                            .chooseBookingDetails
                                            .getString(context)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(LocaleData.cancel
                                                .getString(context)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('booking')
                                                  .doc(booking.id)
                                                  .update({
                                                'chosen': true,
                                                'status': 'confirmed'
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text(LocaleData.bestatigt
                                                .getString(context)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  LocaleData.wahlen.getString(context),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Poppins-Bold',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showDetailDialog(
      BuildContext context, Map<String, dynamic> data, String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            List<Map<String, dynamic>> components =
                List<Map<String, dynamic>>.from(data['komponente']);
            List<Map<String, dynamic>> accessories =
                List<Map<String, dynamic>>.from(data['zubehoer']);

            List<bool> componentDone = components
                .map((component) => component['done'] as bool)
                .toList();
            List<bool> accessoryDone = accessories
                .map((accessory) => accessory['done'] as bool)
                .toList();

            return AlertDialog(
              title: Text(LocaleData.details.getString(context)),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleData.komponente.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    for (int i = 0; i < components.length; i++)
                      CheckboxListTile(
                        title: Text(components[i]['name']),
                        value: componentDone[i],
                        onChanged: (bool? value) {
                          setState(() {
                            componentDone[i] = value ?? false;
                            components[i]['done'] = componentDone[i];
                          });
                        },
                      ),
                    Text(
                      LocaleData.zubehoer.getString(context),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    for (int i = 0; i < accessories.length; i++)
                      CheckboxListTile(
                        title: Text(accessories[i]['name']),
                        value: accessoryDone[i],
                        onChanged: (bool? value) {
                          setState(() {
                            accessoryDone[i] = value ?? false;
                            accessories[i]['done'] = accessoryDone[i];
                          });
                        },
                      ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(LocaleData.cancel.getString(context)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showAddSparePartDialog(context, bookingId);
                  },
                  child: Text(LocaleData.addSpareParts.getString(context)),
                ),
                TextButton(
                  onPressed: () {
                    updateBookingDetails(bookingId, components, accessories);
                    Navigator.pop(context);
                  },
                  child: Text(LocaleData.save.getString(context)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showAddSparePartDialog(BuildContext context, String bookingId) {
    final spareParts = FahrrarztProvider().fahrrarzt.warehouse!.keys.toList();
    final List<bool> selectedParts =
        List<bool>.filled(spareParts.length, false);
    final Map<Sparepart, TextEditingController> partPriceControllers = {
      for (var part in spareParts)
        part: TextEditingController(text: part.sellPrice.toString()),
    };

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: Text(LocaleData.addSpareParts.getString(context)),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < spareParts.length; i++)
                        Column(
                          children: [
                            CheckboxListTile(
                              title: Text(
                                  '${spareParts[i].name} - ${spareParts[i].sellPrice}'),
                              value: selectedParts[i],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedParts[i] = value ?? false;
                                });
                              },
                            ),
                            if (selectedParts[i])
                              TextField(
                                controller: partPriceControllers[spareParts[i]],
                                decoration: InputDecoration(
                                  labelText: 'Price for ${spareParts[i].name}',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(LocaleData.cancel.getString(context)),
                  ),
                  TextButton(
                    onPressed: () {
                      addSpareParts(bookingId, spareParts, selectedParts,
                          partPriceControllers);
                      Navigator.pop(context);
                    },
                    child: Text(LocaleData.addSpareParts.getString(context)),
                  )
                ]);
          });
        });
  }

  void addSpareParts(
      String bookingId,
      List<Sparepart> parts,
      List<bool> selectedParts,
      Map<Sparepart, TextEditingController> partPriceControllers) {
    final List<Map<String, dynamic>> spareParts = [];
    for (int i = 0; i < selectedParts.length; i++) {
      if (selectedParts[i]) {
        spareParts.add({
          'name': parts[i].name,
          'price': int.parse(partPriceControllers[parts[i]]!.text),
          'confirmed': false,
        });
      }
    }
    FirebaseFirestore.instance.collection('booking').doc(bookingId).update({
      'additionalSpareParts': FieldValue.arrayUnion(spareParts),
    });
  }

  void updateBookingDetails(
      String bookingId,
      List<Map<String, dynamic>> components,
      List<Map<String, dynamic>> accessories) {
    FirebaseFirestore.instance.collection('booking').doc(bookingId).update({
      'komponente': components,
      'zubehoer': accessories,
      'status': 'processing',
    });
  }
}

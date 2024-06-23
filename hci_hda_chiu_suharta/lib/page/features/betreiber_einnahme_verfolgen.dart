import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hci_hda_chiu_suharta/class/Booking.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/page/home/betreiber_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../localization/locales.dart';
import 'package:logger/logger.dart';



Color primaryColor = lightColorScheme.primary;
Color bgColor = lightColorScheme.background;
Color unselectedLabelColor = Color(0xff5f6368);
Color secondaryColor = Color.fromARGB(245, 189, 189, 189);

class EinnahmeVerfolgen extends StatefulWidget {
  final String userId;
  EinnahmeVerfolgen({Key? key, required this.userId}) : super(key: key);

  @override
  State<EinnahmeVerfolgen> createState() => _EinnahmeVerfolgenState();
}

class _EinnahmeVerfolgenState extends State<EinnahmeVerfolgen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


    var logger = Logger();


  List<bool> _isExpandedList = List<bool>.generate(20, (_) => false); 
  var _einnahme = 0;
  final _tabs = [
    Tab(text: LocaleData.einnahme),
    Tab(text: LocaleData.ausgabe),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);


    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'FAHRRARZT',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Color(0xff5f6368),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEinnahmeList(),
                  _buildAusgabeList(),
                ],
              ),
            ),
            _buildSubtotal()
          ],
        ),
      ),
    );
  }

  Widget _buildEinnahmeList() {
  final firestore = FirebaseFirestore.instance;

  return FutureBuilder<QuerySnapshot>(
    future: firestore.collection('booking').get(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No bookings found.'));
      }

      final bookings = snapshot.data!.docs;

      return ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return _buildEinnahmeTrailing(
            booking.id,
            booking['price'],
            booking['userId'],
            List<String>.from(booking['komponente'].map((item) => item['name'])),
            _isExpandedList,
            index,
            booking['status'],
          );
        },
      );
    },
  );
}


Widget _buildEinnahmeTrailing(String bookingId, int price, String userId, List<String> ersatzteile, List<bool> isExpandedList, int index, String status) {
  double containerHeight = 0.0;

  if (isExpandedList.isNotEmpty && isExpandedList.length > index && isExpandedList[index]) {
    int ersatzteileCount = ersatzteile.length;
    if (ersatzteileCount >= 1 && ersatzteileCount <= 3) {
      containerHeight = 200.0;
    } else if (ersatzteileCount >= 4 && ersatzteileCount <= 6) {
      containerHeight = 250.0;
    } else if (ersatzteileCount >= 7 && ersatzteileCount <= 19) {
      containerHeight = 300.0;
    } else if (ersatzteileCount >= 10 && ersatzteileCount <= 12) {
      containerHeight = 350.0;
  }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            if (isExpandedList.isNotEmpty && isExpandedList.length > index) {
              isExpandedList[index] = !isExpandedList[index];
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: bgColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleData.buchung_id.getString(context),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Text(
                    bookingId,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LocaleData.price.getString(context),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Text(
                    '\€$price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Icon(
                isExpandedList.isNotEmpty && isExpandedList.length > index && isExpandedList[index]
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
      ),
      AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: containerHeight,
        child: isExpandedList.isNotEmpty && isExpandedList.length > index && isExpandedList[index]
            ? Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Grey background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(LocaleData.kunde_id.getString(context), style: TextStyle(fontSize: 14)),
                          SizedBox(width: 8),
                          Text(
                            '$userId',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('Status: ', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 8),
                          Text('$status', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(LocaleData.ersatzteile.getString(context), style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ersatzteile.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String ersatzteil = entry.value;
                          return Text(
                            '- $ersatzteil',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    ],
  );
}


  Widget _buildAusgabeList() {
    Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;

    return Container(
      child: ListView.builder(
        itemCount: fahrrarzt.warehouse!.length,
        itemBuilder: (context, index) {
          final warehouse = fahrrarzt.warehouse!;
          final sparepart = warehouse.keys.elementAt(index);
          final quantity = warehouse[sparepart] ?? 0;
          final totalPrice = quantity * sparepart.buyPrice!;

          return Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sparepart.name ?? 'Unknown',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4), 
                          Text(
                            '${LocaleData.amount.getString(context)}: $quantity',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${LocaleData.total.getString(context)}:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4), 
                        Text(
                          '\€${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(), 
            ],
          );
        },
      ),
    );
  }

  Widget _buildSubtotal() {
    int betrag = 0;
    int einnahme = 0;
    int ausgabe = 0;

    Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
    final firestore = FirebaseFirestore.instance;

    final warehouse = fahrrarzt.warehouse!;

    // Calculate Einnahme
    firestore.collection('booking').get().then((querySnapshot) {
      int tempEinnahme = 0;
      for (var doc in querySnapshot.docs) {
        int price = (doc['price']);
        tempEinnahme += price;
      }
      if (mounted) {
        setState(() {
          _einnahme = tempEinnahme;
        });
      }
    }).catchError((error) {
      print('Error getting documents: $error');
    });    

    // Calculate Ausgabe 
    for (int i = 0; i < fahrrarzt.warehouse!.length; i++) {
      var sparepart = warehouse.keys.elementAt(i);
      int quantity = warehouse[sparepart] ?? 0;
      int totalPrice = quantity * sparepart.buyPrice!;
      ausgabe += totalPrice;
    }

    // Calculate Betrag
    betrag = _einnahme - ausgabe;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Divider(height: 20, color: Colors.grey), 

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${LocaleData.einnahme.getString(context)}: \€ $_einnahme',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                )
              )
            ]
          ),

          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${LocaleData.ausgabe.getString(context)}: \€ $ausgabe',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                )
              ),
            ]
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${LocaleData.betrag.getString(context)}:   ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '\€ $betrag',           
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: betrag >= 0 ? Colors.green : Colors.red
                    ),
                  ),
                ],
              ),
              _buildCloseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => BetreiberHome(userId: widget.userId)),
          ),
        );
      },
      child: Text(
        'Close',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/page/home/betreiber_home.dart';
import 'package:hci_hda_chiu_suharta/page/home/techniker_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Color primaryColor = lightColorScheme.primary;
Color bgColor = lightColorScheme.background;
Color unselectedLabelColor = Color(0xff5f6368);

class AuslastungVerfolgen extends StatefulWidget {
  final String userId;
  AuslastungVerfolgen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AuslastungVerfolgen> createState() => _AuslastungVerfolgenState();
}

class _AuslastungVerfolgenState extends State<AuslastungVerfolgen> with SingleTickerProviderStateMixin {

  
  
  late TabController _tabController;
  

  final _tabs = [
    Tab(text: 'Komponente'),
    Tab(text: 'Zubehör'),
  ];

  List<bool> _komponenteChecked = List.generate(5, (_) => false);
  List<bool> _zubehoerChecked = List.generate(4, (_) => false);
  List<int> _quantities = List.generate(9, (index) => 0);

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
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'FAHRRARZT',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            letterSpacing: 2.0,
            color: bgColor,
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
              labelColor: primaryColor,
              indicatorColor: primaryColor,
              unselectedLabelColor: unselectedLabelColor,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildKomponenteList(),
                  _buildZubehoerList(),
                ],
              ),
            ),
            _buildSubtotal()
          ],
        ),
      ),
    );
  }

  Widget _buildKomponenteList() {
  return Consumer<FahrrarztProvider>(
    builder: (context, fahrrarztProvider, _) {
      final fahrrarzt = fahrrarztProvider.fahrrarzt;
      final warehouse = fahrrarzt.warehouse;

      if (warehouse == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        color: bgColor,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            final sparepart = warehouse.keys.elementAt(index);
            return Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sparepart.name ?? 'Unknown Part'),
                          Text(
                            'In Stock: ${warehouse[sparepart]}',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Text('\$${sparepart.buyPrice?.toStringAsFixed(2) ?? '0.00'}'),
                    ],
                  ),
                  trailing: _buildKomponenteTrailing(index),
                ),
                Divider(height: 1, color: Colors.grey),
              ],
            );
          },
        ),
      );
    },
  );
}

Widget _buildZubehoerList() {
  return Consumer<FahrrarztProvider>(
    builder: (context, fahrrarztProvider, _) {
      final fahrrarzt = fahrrarztProvider.fahrrarzt;
      final warehouse = fahrrarzt.warehouse;

      if (warehouse == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        color: bgColor,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, tabIndex) {
            final sparepart = warehouse.keys.elementAt(tabIndex + 5);
            return Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sparepart.name ?? 'Unknown Part'),
                          Text(
                            'In Stock: ${warehouse[sparepart]}',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Text('\$${sparepart.buyPrice?.toStringAsFixed(2) ?? '0.00'}'),
                    ],
                  ),
                  trailing: _buildZubehoerTrailing(tabIndex),
                ),
                Divider(height: 1, color: Colors.grey),
              ],
            );
          },
        ),
      );
    },
  );
}

  

  Widget _buildKomponenteTrailing(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: Colors.blue),
          onPressed: () {
            setState(() {
              if (_quantities[index] > 0) {
                _quantities[index]--;
              }
            });
          },
        ),
        Text('${_quantities[index]}'),
        IconButton(
          icon: Icon(Icons.add, color: Colors.blue),
          onPressed: () {
            setState(() {
              _quantities[index]++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildZubehoerTrailing(int index) {
    int realIndex = index + 5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: Colors.blue),
          onPressed: () {
            setState(() {
              if (_quantities[realIndex] > 0) {
                _quantities[realIndex]--;
              }
            });
          },
        ),
        Text('${_quantities[realIndex]}'),
        IconButton(
          icon: Icon(Icons.add, color: Colors.blue),
          onPressed: () {
            setState(() {
              _quantities[realIndex]++;
            });
          },
        ),
      ],
    );
  }

Widget _buildSubtotal() {
  final fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
  final warehouse = fahrrarzt.warehouse;

  int totalPrice = 0;

  // Calculate Komponente prices
  for (int i = 0; i < _quantities.length; i++) {
    var sparepart = warehouse!.keys.elementAt(i);
    totalPrice += (_quantities[i] * sparepart.buyPrice!);
  }

  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal: \$ $totalPrice',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        _buildConfirmButton(), // Call _buildConfirmButton() directly here
      ],
    ),
  );
}

Widget _buildConfirmButton() {
  final fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
  final firestore = FirebaseFirestore.instance;

  String userId = widget.userId;
  return FutureBuilder<DocumentSnapshot>(
    future: firestore.collection('user').doc(userId).get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return ElevatedButton(
          onPressed: null,
          child: Text('Confirm'),
        );
      }

      if (snapshot.hasError) {
        return ElevatedButton(
          onPressed: null,
          child: Text('Confirm'),
        );
      }

      if (!snapshot.hasData || !snapshot.data!.exists) {
        return ElevatedButton(
          onPressed: null,
          child: Text('Confirm'),
        );
      }

      Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;

      String? role = userData?['role'];

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _quantities.any((quantity) => quantity > 0) ? primaryColor : Colors.grey,
        ),
        onPressed: _quantities.any((quantity) => quantity > 0)
            ? () async {
                for (int i = 0; i < _quantities.length; i++) {
                  if (_quantities[i] == 0) {
                    continue;
                  } else {
                    var sparepart = fahrrarzt.warehouse!.keys.elementAt(i);
                    String sparepartName = sparepart.name.toString();
                    int totalStock = fahrrarzt.warehouse![sparepart]! + _quantities[i]!;
                    await updateFirestoreStock(totalStock, sparepartName);
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ersatzteile erfolgreich bestellt'),
                  ),
                );

                if (role == 'Betreiber') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BetreiberHome(
                        userId: widget.userId,
                      ),
                    ),
                    (route) => false,
                  );
                } else if (role == 'Techniker') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TechnikerHome(
                        userId: widget.userId,
                      ),
                    ),
                    (route) => false,
                  );
                }
              }
            : null,
        child: Text(
          'Confirm',
          style: TextStyle(
            color: bgColor,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
      );
    },
  );
}




Future<void> updateFirestoreStock(int stock, String sparepartName) async{
  final firestore = FirebaseFirestore.instance;

  await firestore.collection('stock').doc('BlQHxe7XnhytZnMzDxNW').update({
    '$sparepartName' : stock
  });
}

}



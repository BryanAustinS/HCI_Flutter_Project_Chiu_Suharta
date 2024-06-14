import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/class/Booking.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/page/home/betreiber_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:provider/provider.dart';


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
  List<bool> _isExpandedList = List.generate(10, (_) => false);  // Initial state for 10 items

  final _tabs = [
    Tab(text: 'Einnahme'),
    Tab(text: 'Ausgabe'),
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
    List<int> items = List<int>.generate(10, (index) => index); //LIST OF BOOKINGS

    return ListView.builder(
      itemCount: items.length, //LENGTH OF BOOKING
      itemBuilder: (context, index) {
        return _buildEinnahmeTrailing(index);
      },
    );
  }
  
  Widget _buildEinnahmeTrailing(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            _isExpandedList[index] = !_isExpandedList[index];
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: secondaryColor),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buchung ID: BOOKING_ID_$index', //SHOW BOOKING ID
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '\$PRICE', //SHOW PRICE
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                _isExpandedList[index] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
      ),
      AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isExpandedList[index] ? 100.0 : 0.0,
        child: _isExpandedList[index]
            ? Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //OUTPUTS THE DETAILS
                    Text('Kunde ID: KUNDE_ID_$index'),
                    Text('Techniker ID: TECHNIKER_ID_$index'),
                    Text('Ersatzteil: '),
                  ],
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
                          'Amount: $quantity',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4), // Adjust vertical spacing between texts
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(), // Optional divider between items
          ],
        );
      },
    ),
  );
}





  Widget _buildSubtotal() {
    int nettoIncome = 0;
    int einnahme = 0;
    int ausgabe = 0;

    // CALCULATE EINNAHME HERE


    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Divider(height: 20, color: Colors.grey), 

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Einnahme: \$ $einnahme',
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
                'Ausgabe:   \$ $ausgabe',
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
                    'Betrag:   ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                '\$ $nettoIncome',           
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: nettoIncome >= 0 ? Colors.green : Colors.red
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







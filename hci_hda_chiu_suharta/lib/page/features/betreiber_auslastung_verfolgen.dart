import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/page/home/betreiber_home.dart';
import 'package:hci_hda_chiu_suharta/page/home/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:provider/provider.dart';


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
  Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;

return Container(
      color: lightColorScheme.background,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          final warehouse = fahrrarzt.warehouse;
          if (warehouse == null) {
            return ListTile(
              title: Text('No data available'),
            );
          }
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
}

  Widget _buildZubehoerList() {
  Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
  return Container(
    color: lightColorScheme.background,
    child: ListView.builder(
      itemCount: 4,
      itemBuilder: (context, tabIndex) {
        final warehouse = fahrrarzt.warehouse;
        if (warehouse == null) {
          return ListTile(
            title: Text('No data available'),
          );
        }
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
                      Text(sparepart.name!),
                      Text(
                          'In Stock: ${warehouse[sparepart]}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                  Text('\$${sparepart.buyPrice!.toStringAsFixed(2)}'),
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
  Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
  final warehouse = fahrrarzt.warehouse;

  int totalPrice = 0;

  //Calculate Komponente prices
  for (int i = 0; i < _quantities.length; i++){
    var sparepart = warehouse!.keys.elementAt(i);
    totalPrice += (_quantities[i]*sparepart.buyPrice!);
  }

  //Calculate zubehoer prices
  

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
        _buildConfirmButton(),
      ],
    ),
  );
}

Widget _buildConfirmButton() {
  Fahrrarzt fahrrarzt = Provider.of<FahrrarztProvider>(context).fahrrarzt;
  final warehouse = fahrrarzt.warehouse;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: _quantities.any((quantity) => quantity > 0)
          ? primaryColor
          : Colors.grey, 
    ),
    onPressed: _quantities.any((quantity) => quantity > 0)
        ? () {
        for (int i = 0; i < _quantities.length; i++) {
          var sparepart = warehouse!.keys.elementAt(i);
          if (warehouse[sparepart] != null) {
            if (_quantities[i] != null && warehouse[sparepart] != null) {
              warehouse[sparepart] = warehouse[sparepart]! + _quantities[i]!;
            }
          }
        }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ersatzteile erfolgreich bestellt'),
              ),
            );

            Future.delayed(const Duration(seconds: 0), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BetreiberHome(
                  userId: widget.userId,
                )),
              );
            });
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
}

}



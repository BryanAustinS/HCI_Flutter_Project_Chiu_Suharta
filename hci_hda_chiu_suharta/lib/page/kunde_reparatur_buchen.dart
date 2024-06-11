import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:hci_hda_chiu_suharta/page/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';

Color primaryColor = lightColorScheme.primary;
Color bgColor = lightColorScheme.background;
Color unselectedLabelColor = Color(0xff5f6368);


class ReparaturBuchen extends StatefulWidget {
  ReparaturBuchen({Key? key}) : super(key: key);

  @override
  State<ReparaturBuchen> createState() => _ReparaturBuchenState();
}

class _ReparaturBuchenState extends State<ReparaturBuchen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    Tab(text: 'Komponente'),
    Tab(text: 'Zubehör'),
  ];

  List<bool> _komponenteChecked = List.generate(5, (_) => false);
  List<bool> _zubehoerChecked = List.generate(3, (_) => false);

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
            _buildSubtotal(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

Widget _buildKomponenteList() {
  return Container(
    color: lightColorScheme.background,
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(_getKomponenteItemText(index)),
              trailing: _buildKomponenteTrailing(index),
            ),
            if(_komponenteChecked[index])
              _buildToggleWidget(index),
            Divider(height: 1, color: Colors.grey), // Divider between items
          ],
        );
      },
    ),
  );
}

Widget _buildZubehoerList() {
    return Container(
      color: lightColorScheme.background,
      child: ListView.builder(
        itemCount: _zubehoerChecked.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Zubehör Item $index'),
            trailing: Checkbox(
              value: _zubehoerChecked[index],
              onChanged: (bool? value) {
                setState(() {
                  _zubehoerChecked[index] = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }

  String _getKomponenteItemText(int index) {
    switch (index) {
      case 0:
        return 'Brakes';
      case 1:
        return 'Chains';
      case 2:
        return 'Saddle';
      case 3:
        return 'Tyres';
      case 4:
        return 'Spokes';
      default:
        return '';
    }
  }

  bool _hasFrontRearOption(int index) {
    return index == 0 || index == 3 || index == 4;
  }

  Widget _buildKomponenteTrailing(int index) {
    return Checkbox(
      value: _komponenteChecked[index],
      onChanged: (bool? value) {
        setState(() {
          _komponenteChecked[index] = value!;

          //Reset value if main checkbox is unchecked
          switch(index){
            case 0:
              frontBrake = false;
              rearBrake = false;
              break;
            case 3:
              frontTyre = false;
              rearTyre = false;
              break;
            case 4:
              frontSpoke = false;
              rearSpoke = false;
              break;
          }
        });
      },
    );
  }

  bool frontBrake = false;
  bool rearBrake = false;
  bool frontTyre = false;
  bool rearTyre = false;
  bool frontSpoke = false;
  bool rearSpoke = false;

Widget _buildToggleWidget(int index) {
  switch (index) {
    case 0:
      return _brakeFrontRearToggle();
    case 3:
      return _tyreFrontRearToggle();
    case 4:
      return _spokeFrontRearToggle();
    default:
      return SizedBox.shrink(); // Placeholder if no special toggle is needed
  }
}

Widget _brakeFrontRearToggle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Front',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            ),
            Switch(
              value: frontBrake,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[0] ? 
              (bool value) {
                setState(() {
                  frontBrake = value;
                });
              } : null
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rear',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
            ),
            Switch(
              value: rearBrake,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[0] ? (bool value) {
                setState(() {
                  rearBrake = value;
                });
              } : null
            ),
          ],
        ),
      ],
    ),
  );
  }

Widget _tyreFrontRearToggle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Front',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            ),
            Switch(
              value: frontTyre,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[3] ? (bool value) {
                setState(() {
                  frontTyre = value;
                });
              } : null
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rear',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
            ),
            Switch(
              value: rearTyre,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[3] ? (bool value) {
                setState(() {
                  rearTyre = value;
                });
              } : null
            ),
          ],
        ),
      ],
    ),
  );
  }

Widget _spokeFrontRearToggle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Front',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            ),
            Switch(
              value: frontSpoke,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[4] ?(bool value) {
                setState(() {
                  frontSpoke = value;
                });
              } : null
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rear',
              style: TextStyle(color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
            ),
            Switch(
              value: rearSpoke,
              activeColor: primaryColor,
              onChanged: _komponenteChecked[4] ?(bool value) {
                setState(() {
                  rearSpoke = value;
                });
              } : null
            ),
          ],
        ),
      ],
    ),
  );
  }

Widget _buildSubtotal() {
  double totalPrice = 0;

  //Calculate the total price
  
  
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
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
    ),
    onPressed: () {
      //Confirm reparatur and back to home menu
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => KundeHome())),
      );
    },
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




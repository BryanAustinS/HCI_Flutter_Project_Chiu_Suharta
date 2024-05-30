import 'package:flutter/material.dart';

class KundeHome extends StatefulWidget {
  const KundeHome({super.key});

  @override
  State<KundeHome> createState() => _KundeHomeState();
}

class _KundeHomeState extends State<KundeHome> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.red;
    Color bgColor = Colors.white;
    Color secondaryColor = Color.fromARGB(245, 245, 245, 245);

    return Scaffold(
      backgroundColor: bgColor,

      // App Bar
      appBar: AppBar(
        title: Text(
          'FAHRRARZT',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            letterSpacing: 2.0,
            color: bgColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
            color: bgColor,
          ),
        ]
      ),
      
      // Reparatur buchen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding to control the distance from the edge
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 170,
            width: 170,
            child: InkWell(
              onTap: () {
                print('Reparatur buchen button clicked');
                // Navigate to page KundeReparaturBuchen
              },
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.construction, 
                      color: primaryColor,
                      size: 40.0,
                    ),
                    SizedBox(height: 10), 
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Reparatur buchen',
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
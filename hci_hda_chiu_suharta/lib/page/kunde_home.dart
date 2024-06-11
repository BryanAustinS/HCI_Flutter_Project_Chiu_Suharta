import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/page/kunde_reparatur_buchen.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';


class KundeHome extends StatefulWidget {
  const KundeHome({super.key});

  @override
  State<KundeHome> createState() => _KundeHomeState();
}

class _KundeHomeState extends State<KundeHome> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = lightColorScheme.primary;
    Color bgColor = lightColorScheme.background;
    Color secondaryColor = Color.fromARGB(245, 245, 245, 245);

    return Scaffold(
      // App Bar
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
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              //Navigate to logout page
            },
            color: bgColor,
          ), 
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              // Reparatur buchen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    print('Reparatur buchen button clicked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => ReparaturBuchen())),
                    );
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
                          size: 100.0,
                        ),
                        SizedBox(height: 10), 
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              'Reparatur buchen',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Poppins',
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
              SizedBox(height: 20), 
              // Antrag verfolgen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    print('Auftrag verfolgen button clicked');
                    // Navigate to page KundeAntragVerfolgen
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
                          Icons.timeline, 
                          color: primaryColor,
                          size: 100.0,
                        ),
                        SizedBox(height: 10), 
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              'Auftrag verfolgen',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Poppins',
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
            ],
          ),
        ),
      ),
    );
  }
}
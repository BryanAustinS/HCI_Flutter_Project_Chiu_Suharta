import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/page/features/betreiber_auslastung_verfolgen.dart';
import 'package:hci_hda_chiu_suharta/page/features/betreiber_einnahme_verfolgen.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:logger/logger.dart';
import '../profile/profile_page.dart';
import '../../localization/locales.dart';
import 'package:flutter_localization/flutter_localization.dart';


class BetreiberHome extends StatefulWidget {
  final String userId;
  const BetreiberHome({super.key, required this.userId});

  @override
  State<BetreiberHome> createState() => _BetreiberHomeState();
}

class _BetreiberHomeState extends State<BetreiberHome> {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    Color primaryColor = lightColorScheme.primary;
    Color bgColor = lightColorScheme.background;
    Color secondaryColor = Color.fromARGB(245, 245, 245, 245);
    var logger = Logger();

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
            icon: Image.asset('assets/images/avatar_profile.png'),
            onPressed: () {
              var profilePicture =
                  Image.asset('assets/images/avatar_profile.png');
              logger.t('Profile button clicked with ' +
                  widget.userId +
                  ' as userId');
              //Navigate to profile page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    profilePicture: profilePicture,
                    userId: widget.userId,
                  ),
                ),
              );
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

              // Einnahme verfolgen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    print('Einnahme verfolgen pressed');
                    // Navigate to page EinnahmeVerfolgen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => EinnahmeVerfolgen(
                          userId: widget.userId))),
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
                          Icons.list_alt, 
                          color: primaryColor,
                          size: 100.0,
                        ),
                        SizedBox(height: 10), 
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              LocaleData.einnahme_verfolgen.getString(context),
                              style: TextStyle(
                                fontSize: 23,
                                color: primaryColor,
                                fontFamily: 'Poppins'
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

              // Ersatzteile ansehen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    print('Ersatzteile verfolgen button pressed');
                    // Navigate to page BetreiberAuslastungVerfolgen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => AuslastungVerfolgen(
                        userId: widget.userId,
                      )))
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
                          Icons.warehouse, 
                          color: primaryColor,
                          size: 100.0,
                        ),
                        SizedBox(height: 10), 
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              LocaleData.ersatzteile_verfolgen.getString(context),
                              style: TextStyle(
                                fontSize: 23,
                                color: primaryColor,
                                fontFamily: 'Poppins'

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
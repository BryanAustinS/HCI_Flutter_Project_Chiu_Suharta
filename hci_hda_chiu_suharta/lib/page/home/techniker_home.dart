import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/page/features/techniker_auftrage_ansehen.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:logger/logger.dart';
import 'package:hci_hda_chiu_suharta/page/features/betreiber_auslastung_verfolgen.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hci_hda_chiu_suharta/localization/locales.dart';
import '../profile/profile_page.dart';

class TechnikerHome extends StatefulWidget {
  final String userId;

  const TechnikerHome({super.key, required this.userId});

  @override
  State<TechnikerHome> createState() => _TechnikerHomeState();
}

class _TechnikerHomeState extends State<TechnikerHome> {
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
              var ProfilePicture =
                  Image.asset('assets/images/avatar_profile.png');
              logger.t('Profile button clicked with ' +
                  widget.userId +
                  ' as userId');
              //Navigate to profile page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    profilePicture: ProfilePicture,
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
              // Reparaturen ansehen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    logger.t('Reparaturen ansehen button clicked');
                    // Navigate to page TechnikerReparaturAnsehen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuftrageAnsehen(),
                      ),
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              LocaleData.auftraege_ansehen.getString(context),
                              style: TextStyle(
                                fontSize: 23,
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
              const SizedBox(height: 20),               
            ],
          ),
        ),
      ),
    );
  }
}

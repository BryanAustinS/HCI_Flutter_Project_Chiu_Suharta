import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hci_hda_chiu_suharta/page/home/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/page/login/welcome_screen.dart';
import 'package:ionicons/ionicons.dart';

import '../../localization/locales.dart';

class ProfilePage extends StatefulWidget {
  final Image profilePicture;

  const ProfilePage({Key? key, required this.profilePicture}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLanguageCode;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLanguageCode = _flutterLocalization.currentLocale!.languageCode;
    print(_currentLanguageCode);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const KundeHome(),
                ),
              );
            }
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleData.settings.getString(context),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              LocaleData.account.getString(context),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Image(
                    image: widget.profilePicture.image,
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Patrick",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Role",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              LocaleData.settings.getString(context),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                    child: Icon(
                      Ionicons.language_outline,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton(
                    value: _currentLanguageCode,
                    items: const [
                      DropdownMenuItem(
                        child: Text("English"),
                        value: "en",
                      ),
                      DropdownMenuItem(
                        child: Text("Deutsch"),
                        value: "de",
                      ),
                    ],
                    onChanged: (value){
                      _setLocale(value);
                    }
                  )
                ]
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade100,
                    ),
                    child: const Icon(
                      Ionicons.log_out_outline,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Log out
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      LocaleData.logout.getString(context),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "de") {
      _flutterLocalization.translate("de");
    }
    setState(() {
      _currentLanguageCode = value;
    });
  }
}

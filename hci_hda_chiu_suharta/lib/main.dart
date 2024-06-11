import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/page/login/welcome_screen.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'localization/locales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();
    configureLocalization();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FahrrarztProvider>(
          create: (_) => FahrrarztProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
      ),
    );
  }

  void configureLocalization(){
    localization.init(mapLocales: LOCALES, initLanguageCode: "de");
    localization.onTranslatedLanguage = onTranslateLanguage;
  }

  void onTranslateLanguage(Locale? locale){
    setState(() {
    });
  }
}

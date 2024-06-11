import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hci_hda_chiu_suharta/page/welcome_screen.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
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
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hci_hda_chiu_suharta/authentication/firebase_user_auth.dart';
import 'package:hci_hda_chiu_suharta/page/home/betreiber_home.dart';
import 'package:hci_hda_chiu_suharta/page/home/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/page/login/sign_up_page.dart';
import 'package:hci_hda_chiu_suharta/page/home/techniker_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:hci_hda_chiu_suharta/widgets/custom_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../localization/locales.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var logger = Logger();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    children: [
                      Text(
                        LocaleData.welcome_back.getString(context),
                        style: GoogleFonts.pacifico(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // Email form
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: LocaleData.enter_email.getString(context),
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      // password form
                      TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          hintText:
                              LocaleData.enter_password.getString(context),
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: agreePersonalData,
                                onChanged: (bool? value) {
                                  setState(() {
                                    agreePersonalData = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              Text(
                                LocaleData.agree_terms.getString(context),
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                lightColorScheme.primary),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formSignInKey.currentState!.validate() &&
                                agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(LocaleData.processing_data
                                      .getString(context)),
                                ),
                              );
                              await _signIn();
                            } else if (!agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please agree to the processing of personal data')),
                              );
                            }
                          },
                          child: Text(
                            LocaleData.sign_in.getString(context),
                            style: GoogleFonts.mavenPro(
                              fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleData.no_account.getString(context),
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              " " + LocaleData.sign_up.getString(context),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signinWithEmailAndPassword(email, password);

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('user').doc(user.uid).get();
        if (userDoc.exists) {
          Map<String, dynamic>? userData =
              userDoc.data() as Map<String, dynamic>?;
          String? role = userData?['role'];

          Fluttertoast.showToast(msg: "User is successfully signed in");

          //Navigate to different homepages based on the role
          if (role == 'Betreiber') {
            Fluttertoast.showToast(msg: "Navigate to betreiber homepage");
            logger.t('User is successfully signed in with ' + user.uid);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BetreiberHome(userId: user.uid)),
              (Route<dynamic> route) => false,
            );
          } else if (role == 'Kunde') {
            Fluttertoast.showToast(msg: "Navigate to kunde homepage");
            logger.t('User is successfully signed in with ' + user.uid);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => KundeHome(userId: user.uid)),
              (Route<dynamic> route) => false,
            );
          } else if (role == 'Techniker') {
            Fluttertoast.showToast(msg: "Navigate to techniker homepage");
            logger.t('User is successfully signed in with ' + user.uid);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => TechnikerHome(userId: user.uid)),
              (Route<dynamic> route) => false,
            );
          } else {
            Fluttertoast.showToast(msg: 'Unknown role');
          }
        } else {
          Fluttertoast.showToast(msg: "No Doc exists");
        }
      } else {
        Fluttertoast.showToast(msg: "Sign in failed");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }

    User? user = await _auth.signinWithEmailAndPassword(email, password);

    if (user != null) {
      Fluttertoast.showToast(msg: "User is succesfully signed in");
    } else {
      Fluttertoast.showToast(msg: "Wrong email or password");
    }
  }
}

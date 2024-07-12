import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hci_hda_chiu_suharta/authentication/firebase_user_auth.dart';
import 'package:hci_hda_chiu_suharta/page/login/sign_in_page.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:hci_hda_chiu_suharta/widgets/custom_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../localization/locales.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  bool agreePersonalData = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var logger = Logger();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(children: [
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
                key: _formSignUpKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleData.get_started.getString(context),
                      style: GoogleFonts.pacifico(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    // Full name form
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(LocaleData.full_name.getString(context)),
                        hintText: LocaleData.enter_full_name.getString(context),
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
                    // Email form
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleData.enter_email.getString(context);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintText: 'LocaleData.enter_email.getString(context)',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Password form
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleData.enter_password.getString(context);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                        ),
                        hintText: LocaleData.enter_password.getString(context),
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
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
                    // i agree to processing
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
                        Flexible(
                          child: Text(
                            LocaleData.agree_personal_data.getString(context),
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    // Signup button
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
                          if (_formSignUpKey.currentState!.validate() &&
                              agreePersonalData) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(LocaleData.processing_data
                                    .getString(context)),
                              ),
                            );
                            await _signUp();
                          } else if (!agreePersonalData) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please agree to the processing of personal data',
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          LocaleData.sign_up.getString(context),
                          style: GoogleFonts.mavenPro(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    // already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleData.have_account.getString(context) + ' ',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            LocaleData.sign_in.getString(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signupWithEmailAndPassword(email, password);

      if (user != null) {
        await _firestore.collection('user').doc(user.uid).set({
          'name': name,
          'email': email,
          'role': 'Kunde',
        });
        logger.t("User is successfully created");
        // Show snackbar with success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User is successfully created'),
          ),
        );
        // Navigate to the SignInScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      } else {
        logger.e("Some error occurred");
        // Show error message
      }
    } catch (e) {
      logger.e("Error: $e");
      // Show error message
    }
  }
}

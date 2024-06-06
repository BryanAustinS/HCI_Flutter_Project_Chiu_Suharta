import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hci_hda_chiu_suharta/authentication/firebase_user_auth.dart';
import 'package:hci_hda_chiu_suharta/page/kunde_home.dart';
import 'package:hci_hda_chiu_suharta/page/sign_up_page.dart';
import 'package:hci_hda_chiu_suharta/page/techniker_home.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:hci_hda_chiu_suharta/widgets/custom_scaffold.dart';

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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
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
                          hintText: 'Enter Email',
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
                          hintText: 'Enter Password',
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
                              const Text(
                                'agree to processing data',
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
                          onPressed: () async {
                            if (_formSignInKey.currentState!.validate() &&
                                agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
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
                          child: const Text('Sign in'),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
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
                              ' Sign up',
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
          if (role == 'betreiber') {
            Fluttertoast.showToast(msg: "Navigate to betreiber homepage");
          } else if (role == 'kunde') {
            Fluttertoast.showToast(msg: "Navigate to kunde homepage");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const KundeHome()),
                (Route<dynamic> route) => false,
            );
          } else if (role == 'techniker') {
            Fluttertoast.showToast(msg: "Navigate to techniker homepage");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const TechnikerHome()),
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

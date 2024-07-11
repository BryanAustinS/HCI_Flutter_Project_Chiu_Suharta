import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hci_hda_chiu_suharta/page/login/sign_in_page.dart';
import 'package:hci_hda_chiu_suharta/page/login/sign_up_page.dart';
import 'package:hci_hda_chiu_suharta/theme/theme.dart';
import 'package:hci_hda_chiu_suharta/widgets/custom_scaffold.dart';
import 'package:hci_hda_chiu_suharta/widgets/welcome_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../localization/locales.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: LocaleData.welcome_title.getString(context),
                          style: GoogleFonts.dancingScript(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ]),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: LocaleData.sign_in.getString(context),
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: LocaleData.sign_up.getString(context),
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

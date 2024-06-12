import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../theme/theme.dart';

class AuftragVerfolgen extends StatefulWidget {
  const AuftragVerfolgen({super.key});

  @override
  State<AuftragVerfolgen> createState() => _AuftragVerfolgenState();
}

class _AuftragVerfolgenState extends State<AuftragVerfolgen> {
  bool result = false;
  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Buchung erstellt",
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: StepperText("Ihre Buchung wurde erstellt"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Buchung Bestätigt",
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: StepperText("Ihre Buchung wurde bestätigt"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "In Bearbeitung",
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: StepperText("Ihre Buchung ist in Bearbeitung"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Fertig",
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconWidget: Stack(
        children: [
          Center(
            child: Icon(
              Icons.history,
              color: Colors.green,
              size: 40,
            ),
          ),
          Center(
            child: SpinKitPulse(
              color: Colors.green,
              size: 200,
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Color primaryColor = lightColorScheme.primary;
    Color bgColor = lightColorScheme.background;
    Color secondaryColor = Color.fromARGB(245, 245, 245, 245);
    return Scaffold(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              "Buchungs verfolgen: ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
            child: Row(children: [
              Container(
                height: 60,
                width: 310,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EAF8),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Buchungsnummer eingeben",
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    result=true;
                  });
                },
                child: Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 2, 31, 0),
            child: Row(
              children: [
                Text(
                  "Ihre Buchung: ",
                  style: TextStyle(fontSize: 25),
                ),
                Spacer(),
                Icon(
                  Icons.close,
                  size: 25,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          result
              ? Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50),
                  child: AnotherStepper(
                    stepperList: stepperData,
                    inActiveBarColor: Colors.orangeAccent,
                    stepperDirection: Axis.vertical,
                    iconWidth: 40,
                    iconHeight: 40,
                  ),
                )
              : Transform(
                  transform: Matrix4.translationValues(0, -50, 0),
                  child: Lottie.asset(
                    'assets/lottie/Searching_lottie.json',
                    height: 500,
                    width: 500,
                  ),
                ),
        ],
      ),
    );
  }
}

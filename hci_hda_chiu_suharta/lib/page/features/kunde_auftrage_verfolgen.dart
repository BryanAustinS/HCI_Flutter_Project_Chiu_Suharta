import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hci_hda_chiu_suharta/class/fahrrarzt.dart';
import 'package:lottie/lottie.dart';
import 'package:logger/logger.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../class/sparepart.dart';
import '../../theme/theme.dart';
import '../../localization/locales.dart';

class AuftragVerfolgen extends StatefulWidget {
  const AuftragVerfolgen({super.key});

  @override
  State<AuftragVerfolgen> createState() => _AuftragVerfolgenState();
}

class _AuftragVerfolgenState extends State<AuftragVerfolgen> {
  final TextEditingController _searchController = TextEditingController();
  bool result = false;
  bool isLoading = false;
  DocumentSnapshot? bookingSnapshot;
  Logger logger = Logger();
  List<StepperData> stepperData = [];
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stepperData = _getinitialStepperData();
  }

  // Define initial stepper data
  List<StepperData> _getinitialStepperData() {
    return [
      StepperData(
        title: StepperText(
          LocaleData.buchung_erstellt.getString(context),
          textStyle: GoogleFonts.mavenPro(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: StepperText(LocaleData.buchung_erstellt.getString(context)),
        iconWidget: _initialIcon(),
      ),
      StepperData(
          title: StepperText(
            LocaleData.buchung_bestatigt.getString(context),
            textStyle: GoogleFonts.mavenPro(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle:
              StepperText(LocaleData.buchung_bestatigt2.getString(context)),
          iconWidget: _initialIcon()),
      StepperData(
          title: StepperText(
            LocaleData.in_bearbeitung.getString(context),
            textStyle: GoogleFonts.mavenPro(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: StepperText(LocaleData.in_bearbeitung2.getString(context)),
          iconWidget: _initialIcon()),
      StepperData(
        title: StepperText(
          LocaleData.fertig.getString(context),
          textStyle: GoogleFonts.mavenPro(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconWidget: _initialFinishIcon(),
      ),
    ];
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  LocaleData.buchungs_verfolgen.getString(context),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 310,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6EAF8),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: LocaleData.buchungsnummer_eingeben
                              .getString(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var bookingId = _searchController.text;
                        logger.i("Searching booking with ID: $bookingId");
                        await _searchBooking(bookingId);
                        setState(() {
                          isLoading = false;
                          result = bookingSnapshot != null;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 2, 31, 0),
                child: Row(
                  children: [
                    Text(
                      LocaleData.ihreBuchung.getString(context),
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          result = false;
                          _searchController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: primaryColor,
                        size: 50,
                      ),
                    )
                  : result
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 50),
                              child: AnotherStepper(
                                stepperList: stepperData,
                                inActiveBarColor: Colors.grey,
                                activeBarColor: Colors.orangeAccent,
                                stepperDirection: Axis.vertical,
                                iconWidth: 40,
                                iconHeight: 40,
                                activeIndex: activeStep,
                              ),
                            ),
                            SizedBox(height: 20),
                            if (activeStep == 2) _buildConfirmPartsButton(),
                            if (activeStep == 3)
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  onPressed: () {
                                    _showFinishDialog();
                                  },
                                  child: Text(
                                    LocaleData.finish_booking
                                        .getString(context),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                          ],
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
        ),
      ),
    );
  }

  Future<void> _searchBooking(String bookingId) async {
    try {
      if (bookingId.isEmpty) {
        logger.e("Booking ID is empty");
        return;
      }
      logger.i("Searching booking with ID: $bookingId");

      final docSnapshot = await FirebaseFirestore.instance
          .collection('booking')
          .doc(bookingId)
          .get();
      if (docSnapshot.exists) {
        bookingSnapshot = docSnapshot;
        final data = bookingSnapshot!.data() as Map<String, dynamic>;
        final status = data['status'];
        logger.i("Booking found: ${data}");
        logger.i("Status from Firestore: $status");

        // update stepper data
        _updateStepperData(status);
      } else {
        logger.w("Booking not found");
        bookingSnapshot = null;
        stepperData = _getinitialStepperData();
        activeStep = 0;
      }
    } catch (e) {
      logger.e(e);
      bookingSnapshot = null;
      stepperData = _getinitialStepperData();
      activeStep = 0;
    }
  }

  void _updateStepperData(String status) {
    stepperData = _getinitialStepperData(); // reset to initial stepper data

    logger.i("Updating stepper data with status: $status");
    // Update stepper data based on status
    switch (status) {
      case 'pending':
        activeStep = 0;
        stepperData[0] = StepperData(
          title: stepperData[0].title,
          subtitle: stepperData[0].subtitle,
          iconWidget: _completedIcon(),
        );
        break;
      case 'confirmed':
        activeStep = 1;
        stepperData[0] = StepperData(
          title: stepperData[0].title,
          subtitle: stepperData[0].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[1] = StepperData(
          title: stepperData[1].title,
          subtitle: stepperData[1].subtitle,
          iconWidget: _completedIcon(),
        );
        break;
      case 'processing':
        activeStep = 2;
        stepperData[0] = StepperData(
          title: stepperData[0].title,
          subtitle: stepperData[0].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[1] = StepperData(
          title: stepperData[1].title,
          subtitle: stepperData[1].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[2] = StepperData(
          title: stepperData[2].title,
          subtitle: stepperData[2].subtitle,
          iconWidget: _completedIcon(),
        );
        break;
      case 'finished':
        activeStep = 3;
        stepperData[0] = StepperData(
          title: stepperData[0].title,
          subtitle: stepperData[0].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[1] = StepperData(
          title: stepperData[1].title,
          subtitle: stepperData[1].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[2] = StepperData(
          title: stepperData[2].title,
          subtitle: stepperData[2].subtitle,
          iconWidget: _completedIcon(),
        );
        stepperData[3] = StepperData(
          title: stepperData[3].title,
          subtitle: stepperData[3].subtitle,
          iconWidget: _completedFinishIcon(),
        );
        break;
      default:
        activeStep = 0;
        logger.w("Unknown status: $status");
        break;
    }
    setState(() {});
  }

  Widget _completedIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
  }

  Widget _completedFinishIcon() {
    return const Stack(
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
    );
  }

  Widget _initialFinishIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: const Icon(
        Icons.history,
        color: Colors.white,
      ),
    );
  }

  Widget _initialIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: const Icon(
        Icons.radio_button_unchecked,
        color: Colors.white,
      ),
    );
  }

  void _showFinishDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(LocaleData.finish_booking.getString(context)),
              content:
                  Text(LocaleData.finish_booking_confirm.getString(context)),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(LocaleData.cancel.getString(context)),
                ),
                TextButton(
                  onPressed: () {
                    _deleteBooking();
                    Navigator.of(context).pop();
                  },
                  child: Text(LocaleData.bestatigt.getString(context)),
                )
              ]);
        });
  }

  Future<void> _deleteBooking() async {
    if (bookingSnapshot != null) {
      await FirebaseFirestore.instance
          .collection('booking')
          .doc(bookingSnapshot!.id)
          .delete();
      setState(() {
        result = false;
        bookingSnapshot = null;
        stepperData = _getinitialStepperData();
        activeStep = 0;
      });
      logger.i("Booking deleted successfully");
    } else {
      logger.w("No booking to delete");
    }
  }

  Widget _buildConfirmPartsButton() {
    final data = bookingSnapshot!.data() as Map<String, dynamic>?;
    final List<dynamic> additionalSpareParts =
        data?['additionalSpareParts'] ?? [];

    bool hasUnconfirmedParts =
        additionalSpareParts.any((part) => part['confirmed'] == false);

    return Center(
        child: Stack(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightColorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () {
            _showConfirmPartsDialog();
          },
          child: Text(
            LocaleData.confirm_parts.getString(context),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        if (hasUnconfirmedParts)
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: const Text(
                    '!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )))
      ],
    ));
  }

  void _showConfirmPartsDialog() {
    if (bookingSnapshot != null) {
      final data = bookingSnapshot!.data() as Map<String, dynamic>?;

      if (data != null) {
        final List<dynamic> additionalSpareParts =
            data['additionalSpareParts'] ?? [];
        final List<bool> selectedParts =
            List<bool>.filled(additionalSpareParts.length, false);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(LocaleData.confirm_parts.getString(context)),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < additionalSpareParts.length; i++)
                          if (additionalSpareParts[i]['confirmed'] == false)
                            CheckboxListTile(
                              title: Text(
                                  '${additionalSpareParts[i]['name']} - \$${additionalSpareParts[i]['price']}'),
                              value: selectedParts[i],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedParts[i] = value ?? false;
                                });
                              },
                            ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(LocaleData.cancel.getString(context)),
                    ),
                    TextButton(
                      onPressed: () {
                        _confirmSpareParts(selectedParts, additionalSpareParts);
                        Navigator.pop(context);
                      },
                      child: Text(LocaleData.bestatigt.getString(context)),
                    ),
                  ],
                );
              },
            );
          },
        );
      } else {
        logger.w("No additional spare parts data available.");
      }
    } else {
      logger.w("No booking available to confirm parts.");
    }
  }

  Future<void> _confirmSpareParts(
      List<bool> selectedParts, List<dynamic> additionalSpareParts) async {
    if (bookingSnapshot != null) {
      final List<Map<String, dynamic>> updatedParts = [];
      double totalPrice = 0;

      for (int i = 0; i < selectedParts.length; i++) {
        if (selectedParts[i]) {
          updatedParts.add({
            'name': additionalSpareParts[i]['name'],
            'price': additionalSpareParts[i]['price'],
            'confirmed': true,
          });
          totalPrice += additionalSpareParts[i]['price'];
        } else {
          updatedParts.add(additionalSpareParts[i]);
        }
      }

      await FirebaseFirestore.instance
          .collection('booking')
          .doc(bookingSnapshot!.id)
          .update({
        'additionalSpareParts': updatedParts,
        'price': FieldValue.increment(totalPrice),
      });

      logger.i("Additional spare parts confirmed successfully.");
    } else {
      logger.w("No booking available to confirm parts.");
    }
  }
}

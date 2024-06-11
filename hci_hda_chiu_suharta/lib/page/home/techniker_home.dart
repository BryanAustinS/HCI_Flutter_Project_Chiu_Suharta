import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TechnikerHome extends StatefulWidget {
  const TechnikerHome({super.key});

  @override
  State<TechnikerHome> createState() => _TechnikerHomeState();
}

class _TechnikerHomeState extends State<TechnikerHome> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.red;
    Color bgColor = Colors.white;
    const Color secondaryColor = Color.fromARGB(245, 245, 245, 245);
    var logger = Logger();

    return Scaffold(
      // App Bar
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'FAHRRARZT',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            letterSpacing: 2.0,
            color: bgColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              //Navigate to logout page
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
                              'Reparaturen ansehen',
                              style: TextStyle(
                                fontSize: 23,
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

              // Auslastung ansehen
              SizedBox(
                height: 275,
                width: 275,
                child: InkWell(
                  onTap: () {
                    logger.t('Auslastung ansehen button clicked');
                    // Navigate to page TechnikerAuslastungAnsehen
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
                          Icons.warehouse, 
                          color: primaryColor,
                          size: 100.0,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              'Auslastung ansehen',
                              style: TextStyle(
                                fontSize: 23,
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
            ],
          ),
        ),
      ),
    );
  }
}
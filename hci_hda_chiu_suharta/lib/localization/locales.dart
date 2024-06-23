import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale('en', LocaleData.EN),
  MapLocale('de', LocaleData.DE),
];


mixin LocaleData{
  static const String kunde_button1 = "button1";
  static const String kunde_button2 = "button2";
  static const String settings = "settings";
  static const String account = "account";
  static const String logout = "logout";
  static const String welcome_title = "welcome_title";
  static const String sign_in = "sign_in";
  static const String sign_up = "sign_up";
  static const String welcome_back = "welcome_back";
  static const String enter_email = "enter_email";
  static const String enter_password = "enter_password";
  static const String agree_terms = "agree_terms";
  static const String processing_data = "processing_data";
  static const String no_account = "no_account";
  static const String get_started = "get started";
  static const String full_name = "full_name";
  static const String agree_personal_data = "agree_personal_data";
  static const String have_account = "have_account";
  static const String enter_full_name = "enter_full_name";

  //Home page
  static const String einnahme_verfolgen = "einnahme_verfolgen";
  static const String ersatzteile_verfolgen = "ersatzteile_verfolgen";
  static const String auftraege_ansehen = "auftraege_ansehen";

  //Reparatur buchen
  static const String subtotal = "subtotal";
  static const String front = "front";
  static const String rear = "rear";
  static const String confirm = "confirm";
  static const String confirm_booking = "Confirm booking";
  static const String confirm_text = "confirm text";
  static const String confirm_text2 = "confirm text2";
  static const String cancel = "cancel";

  //Auftraege verfolgen
  static const String buchung_erstellt = "buchung erstellt";
  static const String buchung_erstellt2 = "buchung erstellt 2";
  static const String buchung_bestatigt = "buchung bestatigt";
  static const String buchung_bestatigt2 = "buchung bestatigt 2";
  static const String in_bearbeitung = "in bearbeitung";
  static const String in_bearbeitung2 = "in bearbeitung2";
  static const String fertig = "fertig";
  static const String buchung_verfolgen = "Buchung verfolgen";
  static const String input_bookingnum = "input booking num";
  static const String ihreBuchung = "Ihre Buchung";
  static const String finish_booking = "finish booking";
  static const String finish_booking_confirm = "finish booking confirm";
  static const String confirm_parts = "confirm parts";
  static const String confirm_parts2 = "confirm parts 2";
  
  //Betreiber Einnahme verfolgen
  static const String einnahme = "Einnahme";
  static const String ausgabe = "Ausgabe";
  static const String price = "price";
  static const String kunde_id = "Kunde ID";
  static const String ersatzteile = "Ersatzteile";
  static const String amount = "Amount";
  static const String total = "Total";
  static const String betrag = "Betrag";

  

  static const Map<String, dynamic> EN = {
    kunde_button1: "Repair booking",
    kunde_button2: "Track orders",
    settings: "Settings",
    account: "Account",
    logout: "Logout",
    welcome_title: "Welcome to FahrrArzt!\n",
    sign_in: "Sign In",
    sign_up: "Sign Up",
    welcome_back: "Welcome back!",
    enter_email: "Enter your email",
    enter_password: "Enter your password",
    agree_terms: "Agree to processing data",
    processing_data: "Processing data",
    no_account: "Don't have an account?",
    get_started: "Get Started",
    full_name: "Full Name",
    agree_personal_data: "I agree to processing personal data",
    have_account: "Already have an account?",
    enter_full_name: "Enter your full name",

    //Home pages
    einnahme_verfolgen: "Track income",
    ersatzteile_verfolgen: "Manage spareparts",
    auftraege_ansehen: "View Bookings",

    //Reparatur buchen
    subtotal: "Subtotal",
    front: "Front",
    rear: "Rear",
    confirm: "Confirm",
    confirm_booking: "Confirm Booking",
    confirm_text: "Are you sure you want to book this repair?",
    cancel: "Cancel",
    confirm_text2: "Repair successfully booked",

    //Auftraege verfolgen
    buchung_erstellt: "Booking created",
    buchung_erstellt2: "Your booking has been created",
    buchung_bestatigt: "Booking confirmed",
    buchung_bestatigt2: "Your booking has been confirmed",
    in_bearbeitung: "In Processing",
    in_bearbeitung2: "Your bicycle is currently being repaired",
    fertig: "Finish",
    buchung_verfolgen: "Track your Booking",
    input_bookingnum: "Input your booking number",
    ihreBuchung: "Your booking",
    finish_booking: "Finish Booking",
    finish_booking_confirm: "Are you sure you want to finish this booking?",
    confirm_parts: "Confirm parts",
    confirm_parts2: "Confirm additional Spareparts",

    //Betreiber Einnahme verfolgen
    einnahme: "Income",
    ausgabe: "Expenses",
    kunde_id: "Customer ID",
    price: "Price",
    ersatzteile: "Spare parts",
    amount: "Amount",
    total: "Total",
    betrag: "Net income",
  };

  static const Map<String, dynamic> DE = {
    kunde_button1: "Reparatur buchen",
    kunde_button2: "Auftrag verfolgen",
    settings: "Einstellungen",
    account: "Konto",
    logout: "Abmelden",
    welcome_title: "Willkommen bei FahrrArzt!\n",
    sign_in: "Anmelden",
    sign_up: "Registrieren",
    welcome_back: "Willkommen zurück!",
    enter_email: "Geben Sie Ihre E-Mail-Adresse ein",
    enter_password: "Geben Sie Ihr Passwort ein",
    agree_terms: "Zustimmen zur Datenverarbeitung",
    processing_data: "Datenverarbeitung",
    no_account: "Sie haben noch kein Konto?",
    get_started: "Los geht's",
    full_name: "Vollständiger Name",
    agree_personal_data: "Ich stimme der Verarbeitung personenbezogener Daten zu",
    have_account: "Haben Sie bereits ein Konto?",
    enter_full_name: "Geben Sie Ihren vollständigen Namen ein",

    //Home pages
    einnahme_verfolgen: "Einnahme verfolgen",
    ersatzteile_verfolgen: "Ersatzteile verfolgen",

    //Reparatur buchen
    subtotal: "Summe",
    front: "Vorderseite",
    rear: "Rückseite",
    confirm: "Bestätigen",
    confirm_booking: "Buchung bestätigen",
    confirm_text: "Möchten Sie diese Reparatur wirklich buchen?",
    cancel: "Abbrechen",
    confirm_text2: "Reparatur erfolgreich gebucht",

    //Auftraege verfolgen
    buchung_erstellt: "Buchung erstellt",
    buchung_erstellt2: "Ihre Buchung wurde erstellt",
    buchung_bestatigt: "Booking bestätigt",
    buchung_bestatigt2: "Ihr Buchung wurde bestätigt",
    in_bearbeitung: "In Bearbeitung",
    in_bearbeitung2: "Ihr Fahrrad wird gerade repariert",
    fertig: "Fertig",
    buchung_verfolgen: "Ihre Buchung verfolgen",
    input_bookingnum: "Buchungsnummer eingeben",
    ihreBuchung: "Ihre Buchung",
    finish_booking: "Buchung beenden",
    finish_booking_confirm: "Möchten Sie diese Buchung wirklich beenden?",
    confirm_parts: "Ersatzteile bestätigen",
    confirm_parts2: "Zusätzliche Ersatzteile bestätigen",

    //Betreiber Einnahme verfolgen
    einnahme: "Einnahme",
    ausgabe: "Ausgabe",
    price: "Preis",
    kunde_id: "Kunde ID",
    ersatzteile: "Ersatzteile",
    amount: "Anzahl",
    total: "Summe",
    betrag: "Betrag",




  };
}
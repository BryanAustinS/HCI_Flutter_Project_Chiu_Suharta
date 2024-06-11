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
  };
}
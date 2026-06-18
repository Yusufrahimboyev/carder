// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Card number`
  String get karta_raqami {
    return Intl.message(
      'Card number',
      name: 'karta_raqami',
      desc: '',
      args: [],
    );
  }

  /// `Name and Surname`
  String get ismi_va_familiyasi {
    return Intl.message(
      'Name and Surname',
      name: 'ismi_va_familiyasi',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get amal_qilish_muddati {
    return Intl.message(
      'Expiration date',
      name: 'amal_qilish_muddati',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message('CVV', name: 'cvv', desc: '', args: []);
  }

  /// `Scan camera`
  String get kamera_orqali_skanerlash {
    return Intl.message(
      'Scan camera',
      name: 'kamera_orqali_skanerlash',
      desc: '',
      args: [],
    );
  }

  /// `Write from here`
  String get shu_yerdan_yozish {
    return Intl.message(
      'Write from here',
      name: 'shu_yerdan_yozish',
      desc: '',
      args: [],
    );
  }

  /// `Check again`
  String get qayta_tekshiring {
    return Intl.message(
      'Check again',
      name: 'qayta_tekshiring',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get kiriting {
    return Intl.message('Enter', name: 'kiriting', desc: '', args: []);
  }

  /// `Expiration date (MM/YY)`
  String get amal_qilish_muddati_mm_yy {
    return Intl.message(
      'Expiration date (MM/YY)',
      name: 'amal_qilish_muddati_mm_yy',
      desc: '',
      args: [],
    );
  }

  /// `Bring the card close to the device`
  String get Kartani_qurilmaga_yaqinlashtiring {
    return Intl.message(
      'Bring the card close to the device',
      name: 'Kartani_qurilmaga_yaqinlashtiring',
      desc: '',
      args: [],
    );
  }

  /// `Bring your Humo or Uzcard to the back of your phone`
  String
  get Humo_yoki_Uzcard_kartangizni_telefoningizning_orqa_tomoniga_yaqinlashtiring {
    return Intl.message(
      'Bring your Humo or Uzcard to the back of your phone',
      name:
          'Humo_yoki_Uzcard_kartangizni_telefoningizning_orqa_tomoniga_yaqinlashtiring',
      desc: '',
      args: [],
    );
  }

  /// `Scan error`
  String get skanerlash_xato_berdi {
    return Intl.message(
      'Scan error',
      name: 'skanerlash_xato_berdi',
      desc: '',
      args: [],
    );
  }

  /// `NFC Scan`
  String get nfc_bilan_skanerlash {
    return Intl.message(
      'NFC Scan',
      name: 'nfc_bilan_skanerlash',
      desc: '',
      args: [],
    );
  }

  /// `Scan camera`
  String get kamera_scan {
    return Intl.message('Scan camera', name: 'kamera_scan', desc: '', args: []);
  }

  /// `Name`
  String get ism_familya {
    return Intl.message('Name', name: 'ism_familya', desc: '', args: []);
  }

  /// `Save`
  String get saqlash {
    return Intl.message('Save', name: 'saqlash', desc: '', args: []);
  }

  /// `Card Scanner`
  String get Cardscanner {
    return Intl.message(
      'Card Scanner',
      name: 'Cardscanner',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

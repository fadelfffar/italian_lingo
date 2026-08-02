// flutter_tts ^4.2.3
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;
  static String _currentLocale = 'it-IT';

  static Future<void> init({String locale = 'it-IT'}) async {
    if (_isInitialized && _currentLocale == locale) return;

    // By setting this to true, the speak() method will return a Future
    // that completes when the speech is finished.
    await _flutterTts.awaitSpeakCompletion(true);

    await _setLocale(locale);
    await _flutterTts.setSpeechRate(0.5); // Normal rate is 0.5
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0); // Normal pitch is 1.0

    _isInitialized = true;
    _currentLocale = locale;
  }

  static Future<void> _setLocale(String locale) async {
    // Try to set the requested locale; fall back to the first available language.
    final dynamic result = await _flutterTts.setLanguage(locale);
    if (result == 0) {
      // Locale not supported on this device — fall back gracefully to English.
      await _flutterTts.setLanguage('en-US');
    }
  }

  static Future<void> play(String text, {String locale = 'it-IT'}) async {
    // Switch locale if needed, then speak.
    if (!_isInitialized || _currentLocale != locale) {
      await init(locale: locale);
    }

    // The speak method will now wait until the audio is complete
    await _flutterTts.speak(text);
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}


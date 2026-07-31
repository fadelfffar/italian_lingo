// flutter_tts ^4.2.3
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    // By setting this to true, the speak() method will return a Future
    // that completes when the speech is finished.
    await _flutterTts.awaitSpeakCompletion(true);

    // Set language for the session
    await _flutterTts.setLanguage("it-IT");
    await _flutterTts.setSpeechRate(0.5); // Normal rate is 0.5
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0); // Normal pitch is 1.0

    _isInitialized = true;
  }

  static Future<void> play(String text) async {
    // Initialize if not already done
    if (!_isInitialized) {
      await init();
    }

    // The speak method will now wait until the audio is complete
    await _flutterTts.speak(text);
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}

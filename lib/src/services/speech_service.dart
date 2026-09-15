import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText speechToText = SpeechToText();

  bool isAvailable = false;
  bool shouldKeepListening = false;
  String lastError = '';

  Future<bool> initialize() async {
    try {
      isAvailable = await speechToText.initialize(
        onError: (error) {
          lastError = error.errorMsg;
        },
      );
    } catch (error) {
      isAvailable = false;
      lastError = error.toString();
    }

    return isAvailable;
  }

  Future<bool> startListening({
    required Function(String text, bool isFinal) onResult,
  }) async {
    if (!isAvailable) {
      return false;
    }

    shouldKeepListening = true;

    try {
      await speechToText.listen(
        onResult: (result) {
          onResult(
            result.recognizedWords,
            result.finalResult,
          );

          if (result.finalResult && shouldKeepListening) {
            restartListening(onResult);
          }
        },
      );

      return true;
    } catch (error) {
      lastError = error.toString();
      shouldKeepListening = false;
      return false;
    }
  }

  Future<void> restartListening(
      Function(String text, bool isFinal) onResult,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!shouldKeepListening) {
      return;
    }

    try {
      await speechToText.listen(
        onResult: (result) {
          onResult(
            result.recognizedWords,
            result.finalResult,
          );

          if (result.finalResult && shouldKeepListening) {
            restartListening(onResult);
          }
        },
      );
    } catch (error) {
      lastError = error.toString();
    }
  }

  Future<void> stopListening() async {
    shouldKeepListening = false;

    try {
      await speechToText.stop();
    } catch (error) {
      lastError = error.toString();
    }
  }

  Future<void> cancelListening() async {
    shouldKeepListening = false;

    try {
      await speechToText.cancel();
    } catch (error) {
      lastError = error.toString();
    }
  }

  bool get isListening => speechToText.isListening;
}
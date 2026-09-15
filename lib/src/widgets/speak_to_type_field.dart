import 'package:flutter/material.dart';
import '../services/speech_service.dart';

class SpeakToTypeField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSpeechResult;
  final ValueChanged<bool>? onListeningChanged;
  final Color? micColor;
  final Color? listeningColor;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const SpeakToTypeField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.onSpeechResult,
    this.onListeningChanged,
    this.micColor,
    this.listeningColor,
    this.decoration,
    this.textStyle,
    this.hintStyle,
  });

  @override
  State<SpeakToTypeField> createState() => SpeakToTypeFieldState();
}

class SpeakToTypeFieldState extends State<SpeakToTypeField> {
  final SpeechService speechService = SpeechService();

  late TextEditingController textController;

  bool isListening = false;
  bool isInitialized = false;

  String textBeforeListening = '';

  @override
  void initState() {
    super.initState();

    textController = widget.controller ?? TextEditingController();
    setupSpeech();
  }

  Future<void> setupSpeech() async {
    final ready = await speechService.initialize();

    if (!mounted) {
      return;
    }

    setState(() {
      isInitialized = ready;
    });
  }

  Future<void> handleMicTap() async {
    if (!widget.enabled || !isInitialized) {
      return;
    }

    if (isListening) {
      await stopSpeech();
      return;
    }

    await startSpeech();
  }

  Future<void> startSpeech() async {
    textBeforeListening = textController.text.trim();

    setState(() {
      isListening = true;
    });

    widget.onListeningChanged?.call(true);

    final started = await speechService.startListening(
      onResult: (text, isFinal) {
        if (!mounted) {
          return;
        }

        final spokenText = text.trim();

        if (spokenText.isEmpty) {
          return;
        }

        final value = textBeforeListening.isEmpty
            ? spokenText
            : '$textBeforeListening $spokenText';

        textController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );

        widget.onSpeechResult?.call(spokenText);
        widget.onChanged?.call(value);

        if (isFinal) {
          setListening(false);
        }
      },
    );

    if (!started && mounted) {
      setListening(false);
      showError();
    }
  }

  Future<void> stopSpeech() async {
    await speechService.stopListening();

    if (!mounted) {
      return;
    }

    setListening(false);
  }

  void setListening(bool value) {
    setState(() {
      isListening = value;
    });

    widget.onListeningChanged?.call(value);
  }

  void showError() {
    final error = speechService.lastError;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error.isEmpty ? 'Unable to start speech recognition.' : error,
        ),
      ),
    );
  }

  InputDecoration getFieldDecoration() {
    if (widget.decoration != null) {
      return widget.decoration!.copyWith(
        suffixIcon: IconButton(
          onPressed: handleMicTap,
          tooltip: isListening ? 'Stop listening' : 'Start listening',
          icon: Icon(
            isListening ? Icons.mic : Icons.mic_none,
            color: isListening
                ? widget.listeningColor ?? Colors.red
                : widget.micColor ?? Colors.grey,
          ),
        ),
      );
    }

    return InputDecoration(
      hintText: widget.hintText ?? 'Speak something...',
      hintStyle: widget.hintStyle,
      suffixIcon: IconButton(
        onPressed: handleMicTap,
        tooltip: isListening ? 'Stop listening' : 'Start listening',
        icon: Icon(
          isListening ? Icons.mic : Icons.mic_none,
          color: isListening
              ? widget.listeningColor ?? Colors.red
              : widget.micColor ?? Colors.grey,
        ),
      ),
      border: const OutlineInputBorder(),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      textController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      style: widget.textStyle,
      onChanged: widget.onChanged,
      decoration: getFieldDecoration(),
    );
  }
}

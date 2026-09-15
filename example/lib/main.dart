import 'package:flutter/material.dart';
import 'package:flutter_speak_to_type/flutter_speak_to_type.dart';

void main() {
  runApp(const SpeakToTypeExampleApp());
}

class SpeakToTypeExampleApp extends StatelessWidget {
  const SpeakToTypeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speak to Type',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        scaffoldBackgroundColor: const Color(0xFFF7F7FA),
      ),
      home: const SpeakToTypeExampleScreen(),
    );
  }
}

class SpeakToTypeExampleScreen extends StatefulWidget {
  const SpeakToTypeExampleScreen({super.key});

  @override
  State<SpeakToTypeExampleScreen> createState() =>
      SpeakToTypeExampleScreenState();
}

class SpeakToTypeExampleScreenState extends State<SpeakToTypeExampleScreen> {
  final TextEditingController controller = TextEditingController();

  bool isListening = false;
  String lastSpeech = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void clearText() {
    controller.clear();

    setState(() {
      lastSpeech = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Speak to Type',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const Text(
              'Write with your voice',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Speak naturally and your words will appear in the text field.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ],
              ),
              child: SpeakToTypeField(
                controller: controller,
                hintText: 'Tap the microphone and start speaking...',
                maxLines: 6,
                micColor: Colors.grey.shade600,
                listeningColor: const Color(0xFFEF4444),
                decoration: InputDecoration(
                  hintText: 'Tap the microphone and start speaking...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                textStyle: const TextStyle(fontSize: 16, height: 1.5),
                onSpeechResult: (text) {
                  setState(() {
                    lastSpeech = text;
                  });
                },
                onListeningChanged: (value) {
                  setState(() {
                    isListening = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  isListening ? Icons.graphic_eq : Icons.mic_none,
                  size: 18,
                  color: isListening
                      ? const Color(0xFFEF4444)
                      : Colors.grey.shade500,
                ),
                const SizedBox(width: 8),
                Text(
                  isListening ? 'Listening...' : 'Ready to listen',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isListening
                        ? const Color(0xFFEF4444)
                        : Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                if (controller.text.isNotEmpty)
                  TextButton.icon(
                    onPressed: clearText,
                    icon: const Icon(Icons.close, size: 17),
                    label: const Text('Clear'),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            if (lastSpeech.isNotEmpty) ...[
              Text(
                'Latest speech',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  lastSpeech,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ],
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 20, color: Color(0xFF4F46E5)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can type normally or use the microphone. '
                      'New speech is added after your existing text.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

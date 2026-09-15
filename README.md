````markdown
# Flutter Speak to Type

A simple and reusable Flutter widget that adds **speech-to-text functionality directly to a text field**.

Users can type normally or tap the microphone to convert spoken English into text.

![Flutter Speak to Type Demo](example/assets/demo.gif)

## Features

- 🎤 Speech-to-text input
- ⌨️ Supports normal text typing
- 📝 Adds spoken text to existing text
- 🔴 Listening state with microphone indicator
- 🔔 Speech recognition error handling
- 🎨 Custom microphone colors
- 🎨 Custom text and hint styles
- 🎨 Custom `InputDecoration`
- 📏 Supports multiple lines
- 🔄 Listening state callback
- 📦 Easy to integrate into existing Flutter applications
- 📱 Android microphone permission support

## Installation

Add `flutter_speak_to_type` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_speak_to_type: ^1.0.0
````

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:flutter_speak_to_type/flutter_speak_to_type.dart';
```

## Basic Usage

```dart
SpeakToTypeField(
  hintText: 'Start speaking...',
  onSpeechResult: (text) {
    print(text);
  },
)
```

## Using a TextEditingController

You can provide your own `TextEditingController` when you need access to the entered text.

```dart
final TextEditingController controller = TextEditingController();

SpeakToTypeField(
  controller: controller,
  hintText: 'Speak something...',
)
```

The spoken text will be added to the existing text.

For example:

```text
Existing text: Hello

Spoken text: how are you

Result: Hello how are you
```

## Multi-line Text Field

Use `maxLines` to create a larger text area.

```dart
SpeakToTypeField(
  maxLines: 5,
  hintText: 'Speak your message...',
)
```

## Custom Styling

The microphone icon and text field can be customized.

```dart
SpeakToTypeField(
  hintText: 'Tap the microphone...',
  micColor: Colors.grey,
  listeningColor: Colors.red,
  textStyle: const TextStyle(
    fontSize: 16,
  ),
)
```

## Custom InputDecoration

You can provide your own `InputDecoration`.

```dart
SpeakToTypeField(
  decoration: const InputDecoration(
    hintText: 'Enter your message',
    border: OutlineInputBorder(),
  ),
)
```

The microphone button is added automatically to the field.

## Listening State

Use `onListeningChanged` to know when speech recognition starts or stops.

```dart
SpeakToTypeField(
  onListeningChanged: (isListening) {
    print('Listening: $isListening');
  },
)
```

## Speech Result

Use `onSpeechResult` to receive the recognized speech.

```dart
SpeakToTypeField(
  onSpeechResult: (text) {
    print('Speech: $text');
  },
)
```

## Text Changes

The widget also supports the normal `TextField` `onChanged` callback.

```dart
SpeakToTypeField(
  onChanged: (value) {
    print('Text: $value');
  },
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_speak_to_type/flutter_speak_to_type.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => ExampleScreenState();
}

class ExampleScreenState extends State<ExampleScreen> {
  final TextEditingController controller = TextEditingController();

  bool isListening = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speak to Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SpeakToTypeField(
          controller: controller,
          hintText: 'Tap the microphone and start speaking...',
          maxLines: 5,
          onListeningChanged: (value) {
            setState(() {
              isListening = value;
            });
          },
          onSpeechResult: (text) {
            print('Speech: $text');
          },
          onChanged: (value) {
            print('Text: $value');
          },
        ),
      ),
    );
  }
}
```

## Android Setup

The application using this package needs microphone permission.

Add the following permission to:

`android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

The permission should be added inside the `<manifest>` element.

Example:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.RECORD_AUDIO"/>

    <application
        android:label="your_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        ...
    </application>

</manifest>
```

## iOS Setup

If you use this package on iOS, add the required microphone and speech recognition usage descriptions to:

`ios/Runner/Info.plist`

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app uses the microphone for speech to text.</string>

<key>NSSpeechRecognitionUsageDescription</key>
<string>This app uses speech recognition to convert your voice into text.</string>
```

## How It Works

The package uses the [`speech_to_text`](https://pub.dev/packages/speech_to_text) plugin for speech recognition.

The `SpeakToTypeField` combines:

* A standard Flutter `TextField`
* A microphone button
* Speech recognition
* Listening state handling
* Speech result callbacks
* Error handling

This makes it possible to add voice input without building the speech recognition logic inside every application.

## API

### SpeakToTypeField

| Property             | Type                     | Default       | Description                         |
| -------------------- | ------------------------ | ------------- | ----------------------------------- |
| `controller`         | `TextEditingController?` | `null`        | Controls the text field             |
| `hintText`           | `String?`                | `null`        | Hint displayed in the field         |
| `maxLines`           | `int`                    | `1`           | Maximum number of text lines        |
| `enabled`            | `bool`                   | `true`        | Enables or disables the field       |
| `onChanged`          | `ValueChanged<String>?`  | `null`        | Called when text changes            |
| `onSpeechResult`     | `ValueChanged<String>?`  | `null`        | Called when speech is recognized    |
| `onListeningChanged` | `ValueChanged<bool>?`    | `null`        | Called when listening state changes |
| `micColor`           | `Color?`                 | `Colors.grey` | Microphone color                    |
| `listeningColor`     | `Color?`                 | `Colors.red`  | Microphone color while listening    |
| `decoration`         | `InputDecoration?`       | `null`        | Custom text field decoration        |
| `textStyle`          | `TextStyle?`             | `null`        | Text field text style               |
| `hintStyle`          | `TextStyle?`             | `null`        | Hint text style                     |

## Supported Platforms

The package is intended for Flutter applications using the speech recognition capabilities provided by the underlying `speech_to_text` plugin.

Platform behavior may depend on the speech recognition services available on the device.

## Example App

A complete example application is included in the `example` directory.

Run the example with:

```bash
cd example
flutter pub get
flutter run
```

## Project Structure

```text
flutter_speak_to_type/
├── example/
│   ├── assets/
│   │   └── demo.gif
│   └── lib/
│       └── main.dart
│
├── lib/
│   ├── models/
│   │   └── speak_to_type_result.dart
│   ├── services/
│   │   └── speech_service.dart
│   ├── widgets/
│   │   └── speak_to_type_field.dart
│   └── flutter_speak_to_type.dart
│
├── pubspec.yaml
├── analysis_options.yaml
├── CHANGELOG.md
├── LICENSE
└── README.md
```

## Dependencies

This package uses:

* [speech_to_text](https://pub.dev/packages/speech_to_text)

## License
MIT License

Copyright (c) 2026 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
T
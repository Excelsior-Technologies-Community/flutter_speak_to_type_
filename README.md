````markdown
# 🎙️ Flutter Speak to Type

A clean and reusable Flutter widget that brings **speech-to-text input directly into a text field**.

Type normally, tap the microphone, and speak. The recognized English speech is automatically added to the text field.

<p align="center">
  <img src="example/assets/demo.gif" alt="Flutter Speak to Type Demo" width="320"/>
</p>

---

## ✨ Features

- 🎤 **Speech-to-text input**
- ⌨️ **Normal text typing**
- 📝 **Append speech to existing text**
- 🔴 **Live listening indicator**
- 🎨 **Custom microphone colors**
- 🎨 **Custom text and hint styles**
- 🧩 **Custom `InputDecoration` support**
- 📏 **Single-line and multi-line support**
- 🔄 **Listening state callback**
- 💬 **Speech result callback**
- ⚡ **Simple integration**
- 🛡️ **Speech recognition error handling**
- 📱 **Android microphone permission support**
- 🍎 **iOS speech recognition configuration**

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_speak_to_type: ^1.0.0
````

Then run:

```bash
flutter pub get
```

> Make sure to use the latest version available for your project.

---

## 🚀 Quick Start

Import the package:

```dart
import 'package:flutter_speak_to_type/flutter_speak_to_type.dart';
```

Then use `SpeakToTypeField` anywhere you normally use a text field:

```dart
SpeakToTypeField(
  hintText: 'Start speaking...',
  onSpeechResult: (text) {
    print(text);
  },
)
```

That's it.

The widget provides the text field, microphone button, speech recognition, and listening state handling.

---

## 🎯 Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_speak_to_type/flutter_speak_to_type.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speak to Type'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SpeakToTypeField(
          hintText: 'Tap the microphone and start speaking...',
        ),
      ),
    );
  }
}
```

---

## 📝 Using a TextEditingController

Use your own `TextEditingController` when you need to read, update, or clear the text.

```dart
final TextEditingController controller = TextEditingController();

SpeakToTypeField(
  controller: controller,
  hintText: 'Speak something...',
)
```

You can access the current value at any time:

```dart
print(controller.text);
```

### Speech is added to existing text

If the field already contains:

```text
Hello
```

and the user says:

```text
How are you?
```

the result becomes:

```text
Hello How are you?
```

This allows users to continue writing without losing their existing text.

---

## 🎤 Listening State

Use `onListeningChanged` when your application needs to know whether speech recognition is active.

```dart
SpeakToTypeField(
  onListeningChanged: (isListening) {
    print('Listening: $isListening');
  },
)
```

This can be useful when you want to:

* Show a custom listening indicator
* Update another widget
* Disable another action while listening
* Display custom status text

Example:

```dart
bool isListening = false;

SpeakToTypeField(
  onListeningChanged: (value) {
    setState(() {
      isListening = value;
    });
  },
)
```

---

## 💬 Speech Result

Use `onSpeechResult` to receive the recognized speech.

```dart
SpeakToTypeField(
  onSpeechResult: (text) {
    print('Recognized speech: $text');
  },
)
```

The callback receives the recognized text as a `String`.

---

## ⌨️ Text Changes

The widget also supports the standard Flutter `onChanged` callback.

```dart
SpeakToTypeField(
  onChanged: (value) {
    print('Current text: $value');
  },
)
```

This works for both:

* Manually typed text
* Speech-generated text

---

## 📏 Multi-line Input

Use `maxLines` when you need a larger text area.

```dart
SpeakToTypeField(
  maxLines: 5,
  hintText: 'Speak your message...',
)
```

For example:

```dart
SpeakToTypeField(
  maxLines: 8,
  hintText: 'Write or speak your message...',
)
```

---

## 🎨 Custom Styling

You can customize the microphone colors and text styles.

```dart
SpeakToTypeField(
  hintText: 'Tap the microphone...',
  micColor: Colors.grey,
  listeningColor: Colors.red,
  textStyle: const TextStyle(
    fontSize: 16,
  ),
  hintStyle: const TextStyle(
    color: Colors.grey,
  ),
)
```

### Available styling options

| Property         | Description                      |
| ---------------- | -------------------------------- |
| `micColor`       | Microphone color when idle       |
| `listeningColor` | Microphone color while listening |
| `textStyle`      | Style of the entered text        |
| `hintStyle`      | Style of the hint text           |

---

## 🧩 Custom InputDecoration

You can provide your own Flutter `InputDecoration`.

```dart
SpeakToTypeField(
  decoration: const InputDecoration(
    hintText: 'Enter your message',
    border: OutlineInputBorder(),
  ),
)
```

The package automatically adds the microphone button to the field while preserving your custom decoration.

For example:

```dart
SpeakToTypeField(
  decoration: InputDecoration(
    hintText: 'Write something...',
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),
)
```

---

## 🎛️ Enable / Disable

The widget can be enabled or disabled using the `enabled` property.

```dart
SpeakToTypeField(
  enabled: false,
  hintText: 'Input disabled',
)
```

By default:

```dart
enabled: true
```

---

## 📱 Android Setup

The application using this package needs microphone permission.

Open:

```text
android/app/src/main/AndroidManifest.xml
```

Add:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

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

The permission must be placed inside the `<manifest>` element.

---

## 🍎 iOS Setup

For iOS, add the required microphone and speech recognition descriptions to:

```text
ios/Runner/Info.plist
```

Add:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app uses the microphone for speech to text.</string>

<key>NSSpeechRecognitionUsageDescription</key>
<string>This app uses speech recognition to convert your voice into text.</string>
```

These descriptions are required when the application requests microphone and speech recognition access.

---

## 🔧 How It Works

`Flutter Speak to Type` combines a normal Flutter `TextField` with speech recognition.

The main widget handles:

```text
TextField
   │
   ├── Manual typing
   │
   ├── Microphone button
   │
   ├── Speech recognition
   │
   ├── Recognized text
   │
   └── Listening state
```

Internally, the package uses the [`speech_to_text`](https://pub.dev/packages/speech_to_text) package for speech recognition.

This keeps the speech recognition logic inside the package so applications can simply use:

```dart
SpeakToTypeField()
```

instead of implementing the microphone and speech handling themselves.

---

## 📚 API Reference

### `SpeakToTypeField`

| Property             | Type                     | Default       | Description                         |
| -------------------- | ------------------------ | ------------- | ----------------------------------- |
| `controller`         | `TextEditingController?` | `null`        | Controls the text field             |
| `hintText`           | `String?`                | `null`        | Hint displayed inside the field     |
| `maxLines`           | `int`                    | `1`           | Maximum number of lines             |
| `enabled`            | `bool`                   | `true`        | Enables or disables the field       |
| `onChanged`          | `ValueChanged<String>?`  | `null`        | Called whenever the text changes    |
| `onSpeechResult`     | `ValueChanged<String>?`  | `null`        | Returns recognized speech           |
| `onListeningChanged` | `ValueChanged<bool>?`    | `null`        | Returns the current listening state |
| `micColor`           | `Color?`                 | `Colors.grey` | Microphone color when idle          |
| `listeningColor`     | `Color?`                 | `Colors.red`  | Microphone color while listening    |
| `decoration`         | `InputDecoration?`       | `null`        | Custom text field decoration        |
| `textStyle`          | `TextStyle?`             | `null`        | Text style                          |
| `hintStyle`          | `TextStyle?`             | `null`        | Hint style                          |

---

## 🧪 Example Application

A complete example application is included in the `example` directory.

The example demonstrates:

* Speech-to-text input
* Manual text editing
* Custom styling
* Listening status
* Speech result display
* Clear text functionality
* Multi-line input

Run the example:

```bash
cd example
flutter pub get
flutter run
```

---

## 📂 Project Structure

```text
flutter_speak_to_type/
│
├── example/
│   ├── assets/
│   │   └── demo.gif
│   │
│   └── lib/
│       └── main.dart
│
├── lib/
│   ├── models/
│   │   └── speak_to_type_result.dart
│   │
│   ├── services/
│   │   └── speech_service.dart
│   │
│   ├── widgets/
│   │   └── speak_to_type_field.dart
│   │
│   └── flutter_speak_to_type.dart
│
├── analysis_options.yaml
├── CHANGELOG.md
├── LICENSE
├── pubspec.yaml
└── README.md
```

---

## 📦 Dependency

This package uses:

* [`speech_to_text`](https://pub.dev/packages/speech_to_text)

The speech recognition functionality is provided by the underlying platform speech recognition services through this dependency.

---



## ⚠️ Important Notes

Speech recognition depends on the device's available speech recognition service.

For the best experience:

* Make sure microphone permission is granted.
* Make sure the device has a working speech recognition service.
* Speech recognition behavior may vary between Android and iOS devices.
* Network availability may affect speech recognition depending on the device's recognition service.


## 📄 License

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


One thing you should verify before pushing: **your actual package version in `pubspec.yaml`**. If it isn't `1.0.0`, replace `^1.0.0` in the README with your real published version.

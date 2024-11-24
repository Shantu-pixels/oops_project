import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../APIs/Apis.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  String fromLanguage = 'English';
  String toLanguage = 'Spanish';
  final textController = TextEditingController();
  String translatedText = 'Translated text will appear here...';
  bool isTranslating = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildLanguageSelector(),
                    const SizedBox(height: 24),
                    _buildInputArea(),
                    const SizedBox(height: 24),
                    _buildTranslatedArea(),
                    const SizedBox(height: 24),
                    _buildTranslateButton(),
                    const SizedBox(height: 24),
                    _buildVoiceControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(color: Colors.blue.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
            'Language Translator',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLanguageDropdown(
              value: fromLanguage,
              onChanged: (value) => setState(() => fromLanguage = value!),
            ),
          ),
          _buildSwapButton(),
          Expanded(
            child: _buildLanguageDropdown(
              value: toLanguage,
              onChanged: (value) => setState(() => toLanguage = value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      items: [
        'English',
        'Spanish',
        'French',
        'German',
        'Italian',
        'Hindi',
        'Bengali',
        'Marathi',
        'Chinese',
        'Japanese',
        'Korean',
        'Russian',
        'Portuguese',
        'Arabic',
        'Turkish',
        'Tamil',
        'Telugu',
        'Gujarati',
        'Punjabi',
        'Urdu'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Icon(Icons.language, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text(value),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
      underline: Container(),
    );
  }

  Widget _buildSwapButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: IconButton(
        icon: const Icon(Icons.swap_horiz, color: Colors.white),
        onPressed: () {
          setState(() {
            final temp = fromLanguage;
            fromLanguage = toLanguage;
            toLanguage = temp;
          });
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return TextField(
      controller: textController,
      maxLines: 4,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Enter text to translate...',
        hintStyle: TextStyle(color: Colors.grey[600]),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildTranslatedArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Translation',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy, size: 20, color: Colors.grey[400]),
                onPressed: () {
                  if (translatedText != 'Translated text will appear here...' &&
                      translatedText != 'Translating...') {
                    Clipboard.setData(ClipboardData(text: translatedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Translation copied to clipboard')),
                    );
                  }
                },
                tooltip: 'Copy translation',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            translatedText,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslateButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: isTranslating ? null : translateText,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          isTranslating ? 'Translating...' : 'Translate',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.mic, color: Colors.grey[400]),
          onPressed: () {},
          tooltip: 'Voice input',
        ),
        IconButton(
          icon: Icon(Icons.volume_up, color: Colors.grey[400]),
          onPressed: () {},
          tooltip: 'Voice output',
        ),
      ],
    );
  }

  Future<void> translateText() async {
    if (textController.text.trim().isEmpty) return;

    setState(() {
      isTranslating = true;
      translatedText = 'Translating...';
    });

    try {
      final prompt = '''
      Translate the following text from $fromLanguage to $toLanguage:
      "${textController.text}"
      Only provide the direct translation without any explanations.''';

      final response = await APIs.generateContent(prompt);

      setState(() {
        translatedText = response;
        isTranslating = false;
      });
    } catch (e) {
      setState(() {
        translatedText = 'Translation failed. Please try again.';
        isTranslating = false;
      });
    }
  }
}

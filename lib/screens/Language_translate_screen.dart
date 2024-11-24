import 'package:flutter/material.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  String fromLanguage = 'English';
  String toLanguage = 'Spanish';
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
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
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade100],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
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

  Widget _buildLanguageDropdown(
      {
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      items: ['English', 'Spanish', 'French', 'German', 'Italian']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              const Icon(Icons.language, size: 20),
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
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
      decoration: InputDecoration(
        hintText: 'Enter text to translate...',
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildTranslatedArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
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
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {},
                tooltip: 'Copy translation',
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Translated text will appear here...',
            style: TextStyle(fontSize: 16),
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
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Translate',
          style: TextStyle(
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
          icon: const Icon(Icons.mic),
          onPressed: () {},
          tooltip: 'Voice input',
        ),
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {},
          tooltip: 'Voice output',
        ),
      ],
    );
  }
}
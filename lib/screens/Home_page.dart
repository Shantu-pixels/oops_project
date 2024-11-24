import 'package:flutter/material.dart';
import 'package:oops_project/components/Custum_Card.dart';
import 'package:oops_project/screens/ChatBox_Screen.dart';
import 'package:oops_project/screens/Language_translate_screen.dart';
import 'ImageGenerator_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToChatbox() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatboxScreen()));
  }

  void navigateToTextToImage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImagegeneratorScreen()));
  }

  void navigateToLanguageTranslator() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TranslatorScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 32),
                    _buildFeatureCards(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
          Icon(Icons.menu, color: Colors.blue),
          const SizedBox(width: 16),
          Text(
            'ULTIMATE AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.1),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.blue),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Ultimate AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore our powerful AI features',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      children: [
        CustomCard(
          lottie: 'chatbox2',
          title: 'AI ChatBox',
          onpress: navigateToChatbox,
        ),
        const SizedBox(height: 16),
        CustomCard(
          lottie: 'text_to_image',
          title: 'Text To Image',
          onpress: navigateToTextToImage,
        ),
        const SizedBox(height: 16),
        CustomCard(
          lottie: 'lang_translate',
          title: 'Language Translator',
          onpress: navigateToLanguageTranslator,
        ),
      ],
    );
  }
}

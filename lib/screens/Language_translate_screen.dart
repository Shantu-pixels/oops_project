import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LanguageTranslateScreen extends StatefulWidget {
  const LanguageTranslateScreen({super.key});

  @override
  State<LanguageTranslateScreen> createState() => _LanguageTranslateScreenState();
}

class _LanguageTranslateScreenState extends State<LanguageTranslateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(
          'Language Translator',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          Lottie.asset('assets/animations/pending.json'),
          SizedBox(height: 50,),

          Text('TO Be Implented.......',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30,color: Colors.white,),),

        ],
      )
    );
  }
}

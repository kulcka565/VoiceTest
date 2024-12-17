import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:speech_to_text/text_to_speech.dart';
import 'speechToText.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
      ),
      home:  const Stt(),
    );
  }
}

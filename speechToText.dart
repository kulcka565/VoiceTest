import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Stt extends StatefulWidget {
  const Stt({Key? key}) : super(key: key);

  @override
  State<Stt> createState() => _SttState();
}

class _SttState extends State<Stt> {
  var text = "Hold the button and start speaking";
  var isListening = false;
  Color bgColor = const Color(0xff00A67E);

  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    checkMicrophoneAvailability();
  }

  void checkMicrophoneAvailability() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() {
        if (kDebugMode) {
          print('Microphone available: $available');
        }
      });
    } else {
      if (kDebugMode) {
        print("The user has denied the use of speech recognition.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: bgColor,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTap: () async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                });
                speechToText.listen(
                    listenFor: const Duration(days: 1),
                    onResult: (result) {
                  setState(() {
                    text = result.recognizedWords;
                  });
                });
              }
            } else {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
            }
          },
          child: CircleAvatar(
            backgroundColor: bgColor,
            radius: 30,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: const Icon(Icons.sort_rounded, color: Colors.white),
        centerTitle: true,
        backgroundColor: bgColor,
        title: const Text('Speech to Text'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // unfocus the text when user taps outside the container
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.only(bottom: 150),
            child: SelectableText(text,
                style: TextStyle(
                    fontSize: 18,
                    color: isListening ? Colors.black87 : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}

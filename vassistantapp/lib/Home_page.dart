import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:vassistantapp/openai_services.dart';
import 'Colors/pallete.dart';
import 'featureBox.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:vassistantapp/openai_services.dart' as i;
//import 'openai_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get speechToText => null;
  final speechToText = SpeechToText();
  final openAIService = OpenAIService();
  String lastWords = '';
  final flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    // initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    //setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BounceInDown(child: const Text('Allen')),
          leading: const Icon(Icons.menu),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 123,
                        width: 123,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          //color: Pallete.assistantCircleColor,
                          borderRadius: BorderRadius.circular(60),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/virtualAssistant.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // chat bubble
              SlideInLeft(
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallete.borderColor),
                      borderRadius: BorderRadius.circular(20)
                          .copyWith(topLeft: Radius.zero),
                    ),
                    child: Text(
                      generatedContent == null
                          ? 'Good Morning, what task can I do for you?'
                          : generatedContent!,
                      style: const TextStyle(
                        color: Pallete.blackColor,
                        fontFamily: 'Cera Pro',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),

              // suggestion text
              SlideInLeft(
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(10).copyWith(left: 40),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Here are a few features",
                      style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontFamily: 'Cera Pro',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // features list

              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureBox(
                        colorr: Pallete.firstSuggestionBoxColor,
                        headerText: "ChatGPT",
                        desText:
                            "A smarter way to stay organized and informed with ChatGPT",
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay),
                      child: const FeatureBox(
                        colorr: Pallete.secondSuggestionBoxColor,
                        headerText: "Dall-E",
                        desText:
                            "Get inspired and stay creative with your personal assistant powered by Dall-E",
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay * 2),
                      child: const FeatureBox(
                        colorr: Pallete.thirdSuggestionBoxColor,
                        headerText: "Smart Voice Assistant",
                        desText:
                            "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: ZoomIn(
          delay: Duration(milliseconds: start + delay * 3),
          child: FloatingActionButton(
            backgroundColor: Pallete.firstSuggestionBoxColor,
            onPressed: () async {
              if (await speechToText.hasPermission &&
                  speechToText.isNotListening) {
                print('Started listening');
                await startListening();
              } else if (speechToText.isListening) {
                final speech = await openAIService.isArtpromptAPI(lastWords);
                if (speech.contains('https')) {
                  generatedImageUrl = speech;
                  generatedContent = null;
                  setState(() {});
                } else {
                  generatedImageUrl = null;
                  generatedContent = speech;
                  setState(() {});
                  //await systemSpeak(speech);
                }
                await stopListening();
                print(lastWords);
              } else {
                await initSpeechToText();
              }
            },
            child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
          ),
        ));
  }
}

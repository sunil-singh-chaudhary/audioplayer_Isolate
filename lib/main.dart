import 'dart:isolate';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

String portName = 'audio_isolate';

fcmBackgroundHandler() async {
  ReceivePort receiver = ReceivePort();
  IsolateNameServer.registerPortWithName(receiver.sendPort, portName);

  receiver.listen((message) async {
    debugPrint('oyeah play $message');
    if (message == "play") {
      await FlutterRingtonePlayer().play(
        looping: true,
        fromAsset: 'assets/ringtone.mp3',
      );
    }
    if (message == "stop") {
      await FlutterRingtonePlayer().stop();
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer? audioPlayer;
  @override
  void initState() {
    super.initState();

    register();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Audio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  IsolateNameServer.lookupPortByName(portName)?.send("play");
                },
                child: const Text('Play'),
              ),
              ElevatedButton(
                onPressed: () {
                  IsolateNameServer.lookupPortByName(portName)?.send("stop");
                },
                child: const Text('Stop'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    fcmBackgroundHandler();
  }
}

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

String portName = 'audio_isolate';

isolateBackgroundHandler() async {
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

class Firstapproach extends StatefulWidget {
  const Firstapproach({super.key});

  @override
  State<Firstapproach> createState() => _FirstapproachState();
}

class _FirstapproachState extends State<Firstapproach> {
  @override
  void initState() {
    super.initState();
    register();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                //! FIRST WAY
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
    );
  }
}

void register() {
  isolateBackgroundHandler();
}

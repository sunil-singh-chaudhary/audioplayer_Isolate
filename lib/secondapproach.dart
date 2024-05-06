import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

final receiveport = ReceivePort();

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _MyAppState();
}

class _MyAppState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    registerother();
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
                  receiveport.sendPort.send('play');
                },
                child: const Text('Play'),
              ),
              ElevatedButton(
                onPressed: () async {
                  receiveport.sendPort.send('stop');
                },
                child: const Text('Stop'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerother() async {
    await Isolate.spawn(
        isolateBackgroundSecondMethod(receiveport.sendPort, 'sdfs'),
        receiveport.sendPort);
  }
}

isolateBackgroundSecondMethod(SendPort mainSendPort, String y) {
  debugPrint('oyeah ${y[0]}');

  final mreceivePort = ReceivePort();
  mainSendPort.send(mreceivePort.sendPort);

  mreceivePort.listen((message) async {
    //NOT WORKING LISTINE EHre
    debugPrint('oyeah play $message');
    if (message == 'play') {
      await FlutterRingtonePlayer().play(
        looping: true,
        fromAsset: 'assets/ringtone.mp3',
      );
    } else if (message == 'stop') {
      await FlutterRingtonePlayer().stop();
    }
  });
}

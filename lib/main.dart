import 'package:flutter/material.dart';
import 'package:isolate_audio/firstapproach.dart';
import 'package:isolate_audio/secondapproach.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SstartApp());
}

class SstartApp extends StatelessWidget {
  const SstartApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Firstapproach(),
                  ),
                );
              },
              child: const Text('First Approach'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homescreen(),
                  ),
                );
              },
              child: const Text('Second Approach'),
            ),
          ],
        ),
      ),
    );
  }
}

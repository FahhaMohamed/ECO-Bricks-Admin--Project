
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Splash screen/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ECO Bricks',
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

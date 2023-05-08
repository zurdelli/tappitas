import 'package:flutter/material.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Build Raiz de la app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tappitas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Tappitas'),
    );
  }
}

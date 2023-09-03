import 'package:flutter/material.dart';
import 'package:tappitas/screens/home/widgets/app_bar.dart';
import 'package:tappitas/screens/library.dart';

import '../formTapa/form_tapa.dart';

// Las statefulWidget se manejan x si solas, se usan cuando otras clases no necesitan
// pedir datos a ellas
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tappitas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MiHome(),
    );
  }
}

class MiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", routes: {
      "/": (context) => Listado(),
      "/formtapa": (context) => CreaTapa()
    });
  }
}

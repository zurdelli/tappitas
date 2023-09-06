import 'package:flutter/material.dart';
import 'package:tappitas/screens/library.dart';
import 'package:tappitas/screens/search.dart';
import '../formTapa/form_tapa.dart';

void main() {
  runApp(MiHome());
}

class MiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", routes: {
      "/": (context) => Listado(),
      "/formtapa": (context) => CreaTapa(),
      "/busqtapa": (context) => Busqueda(),
    });
  }
}

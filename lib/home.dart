import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/slider_provider.dart';
import 'package:tappitas/screens/library/library.dart';
import 'package:tappitas/screens/search/search.dart';
import 'package:tappitas/screens/statistics/statistics.dart';
import 'screens/formTapa/form_tapa.dart';

void main() {
  runApp(MiHome());
}

class MiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SliderProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => Lista(),
          "/formtapa": (context) => CreaTapa(),
          "/busqtapa": (context) => Busqueda(),
          "/statistics": (context) => Statistics(),
        },
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
      ),
    );
  }
}

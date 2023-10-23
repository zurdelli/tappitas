import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/screens/DBExporterImporter/db_importer_exporter.dart';
import 'package:tappitas/screens/about/about.dart';
import 'package:tappitas/screens/formTapa/crea_tapa_expandable.dart';
import 'package:tappitas/screens/library/library.dart';
import 'package:tappitas/screens/search/search.dart';
import 'package:tappitas/screens/statistics/statistics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'screens/formTapa/form_tapa.dart';

void main() {
  runApp(MiHome());
}

class MiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => TapaProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => Lista(),
          "/formtapa": (context) => CreaTapaExpandable(),
          "/busqtapa": (context) => Busqueda(),
          "/statistics": (context) => Statistics(),
          "/about": (context) => About(),
          "/dbie": (context) => DBImporterExporter(
                title: 'DB Manager',
              )
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

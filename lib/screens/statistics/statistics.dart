import 'package:flutter/material.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/screens/statistics/widgets/color_container.dart';
import 'package:tappitas/screens/statistics/widgets/country_container.dart';

class Statistics extends StatefulWidget {
  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<Tapa> tapitas = [];
  Future<List<Map<String, Object?>>>? listaColores;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cargaTapitas();
    });
  }

  /// Carga tapitas sera el metodo encargado del setState
  cargaTapitas() async {
    List<Tapa> auxTapa = await DB.tapas();

    setState(() {
      tapitas = auxTapa;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Statistics"),
        ),
        body: Column(children: [
          Text.rich(TextSpan(children: [
            TextSpan(text: "Cantidad de tapitas: ${tapitas.length}"),
          ])),
          Divider(),
          ColorContainer(),
          Divider(),
          CountryContainer(),
        ]));
  }

  // Future<List<Map<String, Object?>>> fillListaColores() async {
  //   return DB.gimmeSomeData("bgColor");
  // }
}

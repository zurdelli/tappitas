import 'dart:core';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/utilities.dart';

class Busqueda extends StatefulWidget {
  @override
  _ListaBusquedaState createState() => _ListaBusquedaState();
}

class _ListaBusquedaState extends State<Busqueda> {
  List<Tapa> tapitas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      helperMethodToGetTapitas(
          ModalRoute.of(context)!.settings.arguments as List<String>);
    });
  }

  //marC,paiC,tipC,dateC,placeC,fgColC,bgColC
  Future<List<Tapa>> buscaTapitas(List<String> clausula) async {
    final isar = Isar.getInstance();
    List<Tapa> tapasAux = await isar!.tapas
        .filter()
        .breweryContains(clausula[0], caseSensitive: false)
        .brewCountryContains(clausula[1], caseSensitive: false)
        .typeContains(clausula[2], caseSensitive: false)
        .dateContains(clausula[3], caseSensitive: false)
        .placeContains(clausula[4], caseSensitive: false)
        .primColorContains(clausula[5], caseSensitive: false)
        .secoColorContains(clausula[6], caseSensitive: false)
        .findAll();
    return tapasAux;
  }

  /// Tuve que crear este metodo para el setState ya que si lo hacia directamente
  /// en buscaTapitas() no me lo permitia (no se por que)
  helperMethodToGetTapitas(List<String> clausula) async {
    List<Tapa> tappas = await buscaTapitas(clausula);
    setState(() {
      tapitas = tappas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search",
            style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 1.2),
      ),
      //body: Container()
      body: createListview(context, tapitas, helperMethodToGetTapitas,
          ModalRoute.of(context)!.settings.arguments as List<String>),
    );
  }
}

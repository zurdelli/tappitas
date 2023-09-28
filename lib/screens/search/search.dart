import 'dart:core';
import 'package:flutter/material.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/screens/library/widgets/app_bar.dart';
import 'package:tappitas/utilities.dart';

class Busqueda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(titulo: "Búsqueda"), body: ListaBusqueda());
  }
}

class ListaBusqueda extends StatefulWidget {
  @override
  _ListaBusquedaState createState() => _ListaBusquedaState();
}

class _ListaBusquedaState extends State<ListaBusqueda> {
  List<Tapa> tapitas = [];
  List<String> clausulas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      helperMethodToGetTapitas(
          ModalRoute.of(context)!.settings.arguments as List<String>);
    });
  }

  Future<List<Tapa>> buscaTapitas(List<String> clausula) async {
    List<Tapa> tapasAux = await DB.busquedaTapas(
        clausula[0], clausula[1], clausula[2], clausula[3], clausula[4]);
    return tapasAux;
  }

  /// Tuve que crear este metodo para el setState ya que si lo hacia directamente
  /// en buscaTapitas() no me lo permitia (no se por que)
  helperMethodToGetTapitas(List<String> clausula) async {
    var tappas = await buscaTapitas(clausula);
    setState(() {
      tapitas = tappas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Utilities()
        .createListview(context, tapitas, helperMethodToGetTapitas);
  }
}

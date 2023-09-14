import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/screens/widgets/app_bar.dart';
import 'package:tappitas/screens/widgets/utilities.dart';

class Listado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(titulo: "Tappitas"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.popAndPushNamed(context, "/formtapa",
                arguments: Tapa(
                    id: 0,
                    imagen: '',
                    fgColor: '',
                    bgColor: '',
                    fecha: DateFormat('dd-MM-yyyy')
                        .format(DateTime.now())
                        .toString(),
                    lugar: '',
                    marca: '',
                    pais: '',
                    tipo: '',
                    isFavorited: 0,
                    rating: 0.0,
                    modelo: ''));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Lista());
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Tapa> tapitas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cargaTapitas();
    });
  }

  /// Carga tapitas sera el metodo encargado del setState
  cargaTapitas() async {
    /// auxTapa es una lista de tapas obtenida desde la ddbb
    List<Tapa> auxTapa = await DB.tapas();

    setState(() {
      tapitas = auxTapa;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Metodo para crear la listView de forma dinamica
    return Utilities().createListview(context, tapitas, cargaTapitas);
  }
}

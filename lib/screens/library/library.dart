import 'dart:core';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/screens/library/widgets/app_bar.dart';
import 'package:tappitas/utilities.dart';

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
    return Scaffold(
        appBar: MyAppBar(titulo: "Tappitas", cantidad: tapitas.length),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/formtapa",
                    arguments: Tapa(
                        id: 0,
                        imagen: '',
                        primColor: '',
                        secoColor: '',
                        date: DateFormat('dd-MM-yyyy')
                            .format(DateTime.now())
                            .toString(),
                        place: '',
                        brewery: '',
                        brewCountry: '',
                        brewCountryCode: '',
                        type: '',
                        isFavorited: 0,
                        rating: 0.0,
                        model: ''))
                // Necesario para el reload de la listview
                .then((_) => cargaTapitas());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body:

            /// Metodo para crear la listView de forma dinamica
            Utilities().createListview(context, tapitas, cargaTapitas));
  }
}

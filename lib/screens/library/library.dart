import 'dart:core';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/screens/library/widgets/app_bar.dart';
import 'package:tappitas/utilities.dart';

late var lastClausule;

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
      cargaTapitas(lastClausule);
    });
  }

  /// Carga tapitas sera el metodo encargado del setState
  void cargaTapitas(String lastClausule) async {
    /// auxTapa es una lista de tapas obtenida desde la ddbb
    List<Tapa> auxTapa = await DB.tapas(lastClausule);
    setState(() {
      tapitas = auxTapa;
      Provider.of<OrderProvider>(context, listen: false).cantTappas =
          tapitas.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    lastClausule = Provider.of<OrderProvider>(context).orderString;

    return Scaffold(
      appBar: MyAppBar(titulo: "Tappitas", callback: cargaTapitas),
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
              .then((_) => cargaTapitas(lastClausule));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: createListview(context, tapitas, cargaTapitas),
    );
  }
}

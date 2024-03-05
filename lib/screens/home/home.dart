import 'dart:core';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/screens/home/widgets/app_bar.dart';
import 'package:tappitas/utilities.dart';

late String lastOrderMethod;

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Tapa> tapitas = [];
  static late Isar tapasInstance;

  @override
  void initState() {
    super.initState();

    lastOrderMethod = "brewery";

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dir = await getApplicationDocumentsDirectory();

      tapasInstance = await Isar.open(
        [TapaSchema],
        directory: dir.path,
      );
      cargaTapitas(lastOrderMethod);
    });
  }

  /// Carga tapitas sera el metodo encargado del setState
  void cargaTapitas(String lastOrderMethod) async {
    tapasInstance = Isar.getInstance()!;

    /// auxTapa es una lista de tapas obtenida desde la ddbb
    final auxTapa = await tapasInstance.tapas.where().findAll();
    setState(() {
      tapitas = auxTapa;
      context.read<OrderProvider>().cantTappas = tapitas.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    lastOrderMethod = context.read<OrderProvider>().orderString;

    return Scaffold(
        appBar: MyAppBar(titulo: "Tappitas", callback: cargaTapitas),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            clearProvider();
            Navigator.pushNamed(context, "/formtapa", arguments: 0);
            // Necesario para el reload de la listview
            //.then((_) => cargaTapitas(lastOrderMethod));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: createListview(context, tapitas, cargaTapitas, null));
    //body: lista());
  }

  clearProvider() {
    context.read<TapaProvider>().brewCountry = "";
    context.read<TapaProvider>().brewCountryCode = "";
    context.read<TapaProvider>().brewery = "";
    context.read<TapaProvider>().color1 = Colors.transparent;
    context.read<TapaProvider>().color2 = Colors.transparent;
    context.read<TapaProvider>().date = "";
    context.read<TapaProvider>().model = "";
    context.read<TapaProvider>().place = "";
    context.read<TapaProvider>().rating = 0;
    context.read<TapaProvider>().tapaAsString = "";
    context.read<TapaProvider>().type = "";
  }

  // Widget lista() {
  //   //return Container();
  //   return FutureBuilder(
  //       builder: (context, snapshot) => !snapshot.hasData
  //           ? Center(child: CircularProgressIndicator())
  //           : Container(),
  //       future: tapasInstance.tapa.where().findAll());
  // }
}

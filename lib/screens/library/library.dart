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

late String lastOrderMethod;

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
      cargaTapitas(lastOrderMethod);
    });
  }

  /// Carga tapitas sera el metodo encargado del setState
  void cargaTapitas(String lastOrderMethod) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Updating list, please wait..."),
      showCloseIcon: true,
      duration: Duration(seconds: 2),
    ));

    /// auxTapa es una lista de tapas obtenida desde la ddbb
    List<Tapa> auxTapa = await DB.tapas(lastOrderMethod);
    setState(() {
      tapitas = auxTapa;
      Provider.of<OrderProvider>(context, listen: false).cantTappas =
          tapitas.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    lastOrderMethod = Provider.of<OrderProvider>(context).orderString;

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
                        date: DateFormat('yyyy-MM-dd')
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
                .then((_) => cargaTapitas(lastOrderMethod));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: createListview(context, tapitas, cargaTapitas, null));
    //body: lista());
  }

  Widget lista() {
    return FutureBuilder(
        builder: (context, snapshot) => !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : createListview(context, tapitas, cargaTapitas, null),
        future: DB.tapas(lastOrderMethod));
  }
}

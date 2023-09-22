import 'package:flutter/material.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

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
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: "Cantidad de tapitas: ${tapitas.length}"),
              ])),
              ElevatedButton(
                  onPressed: () => setState(() {
                        listaColores = DB.gimmeSomeData("bgColor");
                      }),
                  child: const Text('Gimme Colors')),
              listaColores == null
                  ? const Text('Cliquea el boton')
                  : FutureBuilder(
                      future: listaColores,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List lista = snapshot.data ?? List.empty();
                          Map result = {};
                          List lista2 = [];
                          StringBuffer myString = StringBuffer();
                          lista.forEach(
                            (element) {
                              // element es un mapa
                              myString.write("\n");
                              //element.forEach((k, v) => lista2.add(v));
                              element.forEach((k, v) {
                                myString.write("$v ");
                              });
                            },
                          );

                          //Map mapa = Map.fromIterable

                          return Text('Por color: $myString');
                        } else if (snapshot.hasError) {
                          return Text(
                              'Delivery error: ${snapshot.error.toString()}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
            ])));
  }

  // Future<List<Map<String, Object?>>> fillListaColores() async {
  //   return DB.gimmeSomeData("bgColor");
  // }
}

/// ordering a pizza takes 5 seconds
/// and then gives you a pizza salami with extra cheese
Future<String> orderPizza() {
  return Future<String>.delayed(
      Duration(seconds: 5), () async => 'Pizza Salami, Extra Cheese');
}

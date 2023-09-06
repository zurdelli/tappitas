import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/screens/library.dart';

class Utilities {
  /// Crea la listView que carga todas las tapitas. Recibe la funcion cargaTapitas()
  /// como callback (la llama y se ejecuta el setState)
  ListView createListview(
      BuildContext context, List<Tapa> tapas, Function callback) {
    return ListView.builder(
        itemCount: tapas.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => Dismissible(
              key: Key(i.toString()),
              direction: DismissDirection.startToEnd,
              background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white))),
              onDismissed: (direction) {
                //DB.delete(tapitas[i]);
              },
              confirmDismiss: (direction) async {
                return await _showConfirmationDialogToDeleteTapa(
                    context, i, tapas, callback);
              },
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    text: "${tapas[i].marca} - ",
                    children: <TextSpan>[
                      TextSpan(
                          text: tapas[i].nombre,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "(${tapas[i].pais})",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: tapas[i].imagen.isNotEmpty
                      ? MemoryImage(base64Decode(tapas[i].imagen))
                      : null,
                  radius: 30.0,
                ),
                subtitle: Text(
                    "Tomada el ${tapas[i].fecha.substring(0, 16)} \n${tapas[i].color}"),
                isThreeLine: true,
                trailing: MaterialButton(
                  onPressed: () {
                    //se utiliza este metodo (popAndPushNamed) para terminar
                    // con la pantalla y volver a abrir la otra por problemas
                    // con el globalKey del form
                    Navigator.popAndPushNamed(context, "/formtapa",
                        arguments: tapas[i]);
                  },
                  child: Icon(Icons.edit),
                ),
                onTap: () {
                  Utilities().muestraAlertDialog(context, 1, tapas[i].imagen);
                },
              ),
            ));
  }

  /// Crea el alert de confirmDismiss que debe retornar un bool
  Future<bool?> _showConfirmationDialogToDeleteTapa(
      BuildContext context, int i, List<Tapa> tapas, Function callback) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar"),
          content: Text("¿Está seguro de querer eliminar la tapa?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  //MiLista().setState(() {});
                },
                child: Text("Cancelar")),
            TextButton(
                onPressed: () {
                  DB.delete(tapas[i]);
                  Navigator.pop(context);
                  callback();
                },
                child: Text("Eliminar"))
          ],
        );
      },
    );
  }

  /// AlertDialog para la busqueda de tapas
  /// dialog = 0 -> Busqueda de tapas (alertBusqueda)
  ///        = 1 -> Zoom tapa (alertTapa)
  muestraAlertDialog(BuildContext context, int dialog, String? tapaAsString) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
            child: dialog == 0
                ? alertBusqueda(context)
                : alertTapa(context, tapaAsString ?? 'null')),
      ),
    );
  }

  Widget alertTapa(BuildContext context, String tapaAsStringBase64) {
    //String tapaAsString = tapaAsStringBase64 ?? 'null';
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 250,
            width: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: MemoryImage(base64Decode(tapaAsStringBase64)),
                radius: 200.0,
              ),
            )),
      ],
    );
  }

  ///Crea la pantalla del AlertDialog para la busqueda
  Widget alertBusqueda(BuildContext context) {
    final nomController = TextEditingController();
    final marController = TextEditingController();
    final colController = TextEditingController();
    final paiController = TextEditingController();

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Búsqueda"),
          TextField(
            controller: marController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Marca'),
          ),
          TextField(
            controller: nomController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Tipo de cerveza'),
          ),
          TextField(
            controller: paiController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Pais de procedencia'),
          ),
          TextField(
            controller: colController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Color de la tapa'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  getClausule(context, nomController.text, marController.text,
                      paiController.text, colController.text);
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ]);
  }

  /// Crea la clausula para la busqueda en la bbdd
  void getClausule(BuildContext context, String nomC, String marC, String paiC,
      String colC) {
    if (nomC.isEmpty) nomC = '%';
    if (marC.isEmpty) marC = '%';
    if (paiC.isEmpty) paiC = '%';
    if (colC.isEmpty) colC = '%';

    List<String> myList = [nomC, marC, paiC, colC];
    print("myList: $myList");
    Navigator.popAndPushNamed(context, '/busqtapa', arguments: myList);
  }
}

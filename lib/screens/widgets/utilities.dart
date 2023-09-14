import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              //direction: DismissDirection.startToEnd,
              background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white))),
              secondaryBackground: Container(
                  color: Colors.blue,
                  child: (Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.edit, color: Colors.red),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )))),
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  return await _showConfirmationDialogToDeleteTapa(
                      context, i, tapas, callback);
                } else {
                  Navigator.popAndPushNamed(context, "/formtapa",
                      arguments: tapas[i]);
                }
              },
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${tapas[i].marca} - ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: tapas[i].tipo,
                      ),
                      TextSpan(
                          text: tapas[i].pais.trim().length > 3
                              ? " (${tapas[i].pais.trim().substring(0, 3)})"
                              : "",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      TextSpan(
                        text: " - ${tapas[i].rating}",
                      ),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: tapas[i].imagen.isNotEmpty
                      ? MemoryImage(base64Decode(tapas[i].imagen))
                      : null,
                  radius: 30.0,
                ),
                subtitle:
                    Text("Tomada el ${tapas[i].fecha} \nen ${tapas[i].lugar}"),
                isThreeLine: true,
                trailing: IconButton(
                    onPressed: () {
                      if (tapas[i].isFavorited == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text("Agregado a favs")));
                        DB.updateFavorite(1, tapas[i].id);
                        callback();
                      } else if (tapas[i].isFavorited == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Quitado de favoritos")));
                        DB.updateFavorite(0, tapas[i].id);
                        callback();
                      }
                    },
                    icon: tapas[i].isFavorited == 0
                        ? Icon(Icons.favorite_border)
                        : Icon(Icons.favorite)),
                iconColor: tapas[i].isFavorited == 0 ? Colors.grey : Colors.red,
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
    showDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
            elevation: 10,
            //shape: RoundedRectangleBorder(
            //  borderRadius: BorderRadius.all(Radius.circular(300)),

            child: dialog == 0
                ? alertBusqueda(context)
                : alertTapa(context, tapaAsString ?? 'null')),
      ),
    );
  }

  Widget alertTapa(BuildContext context, String tapaAsStringBase64) {
    //String tapaAsString = tapaAsStringBase64 ?? 'null';
    return Container(
        height: 250,
        width: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(tapaAsStringBase64)),
            radius: 200.0,
          ),
        ));
  }

  ///Crea la pantalla del AlertDialog para la busqueda
  Widget alertBusqueda(BuildContext context) {
    final tipoController = TextEditingController();
    final marController = TextEditingController();
    final fgColorController = TextEditingController();
    final bgColorController = TextEditingController();
    final paiController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Búsqueda"),
            TextField(
              controller: marController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Marca'),
            ),
            TextField(
              controller: tipoController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Tipo de cerveza'),
            ),
            TextField(
              controller: paiController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Pais de procedencia'),
            ),
            TextField(
              controller: fgColorController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Color de frente'),
            ),
            TextField(
              controller: bgColorController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Color de fondo'),
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
                    getClausule(
                        context,
                        marController.text,
                        tipoController.text,
                        paiController.text,
                        fgColorController.text,
                        bgColorController.text);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ]),
    );
  }

  /// Crea la clausula para la busqueda en la bbdd
  void getClausule(BuildContext context, String tipC, String marC, String paiC,
      String fgColC, String bgColC) {
    if (tipC.isEmpty) tipC = '%';
    if (marC.isEmpty) marC = '%';
    if (paiC.isEmpty) paiC = '%';
    if (fgColC.isEmpty) fgColC = '%';
    if (bgColC.isEmpty) bgColC = '%';

    List<String> myList = [tipC, marC, paiC, fgColC, bgColC];
    print("myList: $myList");
    Navigator.popAndPushNamed(context, '/busqtapa', arguments: myList);
  }
}

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:country_picker/src/utils.dart';
import 'package:tappitas/screens/library/library.dart';
import 'package:tappitas/screens/search/dialog_search.dart';

/// Translates color <-> string
String colorToString(Color color) {
  if (color == Colors.red) {
    return "Red";
  } else if (color == Colors.purple) {
    return "Purple";
  } else if (color == Colors.indigo) {
    return "Blue";
  } else if (color == Colors.lightBlue) {
    return "LightBlue";
  } else if (color == Colors.green) {
    return "Green";
  } else if (color == Colors.yellow) {
    return "Yellow";
  } else if (color == Colors.amber) {
    return "Gold";
  } else if (color == Colors.orange) {
    return "Orange";
  } else if (color == Colors.brown) {
    return "Brown";
  } else if (color == Colors.white) {
    return "White";
  } else if (color == Colors.grey) {
    return "Grey";
  } else if (color == Colors.black) {
    return "Black";
  } else {
    return "";
  }
}

/// Translates color <-> string
Color stringToColor(String color) {
  if (color == "Red") {
    return Colors.red;
  } else if (color == "Purple") {
    return Colors.purple;
  } else if (color == "Blue") {
    return Colors.indigo;
  } else if (color == "LightBlue") {
    return Colors.lightBlue;
  } else if (color == "Green") {
    return Colors.green;
  } else if (color == "Yellow") {
    return Colors.yellow;
  } else if (color == "Gold") {
    return Colors.amber;
  } else if (color == "Orange") {
    return Colors.orange;
  } else if (color == "Brown") {
    return Colors.brown;
  } else if (color == "White") {
    return Colors.white;
  } else if (color == "Grey") {
    return Colors.grey;
  } else if (color == "Black") {
    return Colors.black;
  } else {
    return Colors.transparent;
  }
}

List<Color> colors = [
  Colors.red,
  Colors.purple,
  Colors.indigo,
  Colors.lightBlue,
  Colors.green,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.brown,
  Colors.white,
  Colors.grey,
  Colors.black,
];

/// Crea la listView que carga todas las tapitas. Recibe la funcion cargaTapitas()
/// como callback (la llama y se ejecuta el setState)
ListView createListview(
    BuildContext context, List<Tapa> tapas, Function callback) {
  return ListView.builder(
      //shrinkWrap: true,
      //scrollDirection: Axis.vertical,
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
                Navigator.pushNamed(context, "/formtapa", arguments: tapas[i])
                    .then((_) => callback(lastClausule));
              }
              return null;
            },
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${tapas[i].brewery} ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: tapas[i].brewCountryCode.isEmpty
                            ? ""
                            : tapas[i].brewCountryCode),
                    TextSpan(
                      text: tapas[i].model.isEmpty
                          ? tapas[i].type.isEmpty
                              ? ""
                              : " - ${tapas[i].type}"
                          : " - ${tapas[i].model}",
                    ),
                    TextSpan(
                        text: tapas[i].rating == 0.0
                            ? ""
                            : "- ${tapas[i].rating}"),
                  ],
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: tapas[i].imagen.isNotEmpty
                    ? MemoryImage(base64Decode(tapas[i].imagen))
                    : null,
                radius: 30.0,
              ),
              subtitle: tapas[i].place.isEmpty
                  ? Text("Tomada el ${tapas[i].date}")
                  : Text("Tomada el ${tapas[i].date} \nen ${tapas[i].place}"),
              isThreeLine: true,
              trailing: IconButton(
                  onPressed: () {
                    if (tapas[i].isFavorited == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Agregado a favs"),
                        showCloseIcon: true,
                        duration: Duration(seconds: 1),
                      ));
                      DB.updateFavorite(1, tapas[i].id);
                      callback(lastClausule);
                    } else if (tapas[i].isFavorited == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Quitado de favoritos"),
                        showCloseIcon: true,
                        duration: Duration(seconds: 1),
                      ));
                      DB.updateFavorite(0, tapas[i].id);
                      callback(lastClausule);
                    }
                  },
                  icon: tapas[i].isFavorited == 0
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite)),
              iconColor: tapas[i].isFavorited == 0 ? Colors.grey : Colors.red,
              onTap: () {
                muestraAlertDialog(context, tapas[i].imagen, dialog: 'tapas');
              },
              dense: false,
              horizontalTitleGap: 10,
              splashColor: Colors.amber,
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
                callback(lastClausule);
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
muestraAlertDialog(BuildContext context, String? tapaAsString,
    {required String dialog}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
          elevation: 10,
          //shape: RoundedRectangleBorder(
          //  borderRadius: BorderRadius.all(Radius.circular(300)),
          child: dialog == 'busqueda'
              ? DialogSearch()
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
        //color: Colors.white,
      ),
      child: Center(
        child: CircleAvatar(
          backgroundImage: MemoryImage(base64Decode(tapaAsStringBase64)),
          radius: 200.0,
        ),
      ));
}

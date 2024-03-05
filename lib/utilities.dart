import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/screens/home/home.dart';

/// Translates color <-> string
String colorToString(Color color) {
  print("el color es: $color");
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
  } else if (color == Color.fromARGB(255, 255, 101, 153)) {
    return "Pink";
  } else if (color == Color.fromARGB(255, 232, 195, 158)) {
    return "Beige";
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
  } else if (color == "Pink") {
    return Color.fromARGB(255, 255, 101, 153);
  } else if (color == "Beige") {
    return Color.fromARGB(255, 232, 195, 158);
  } else if (color == "Black") {
    return Colors.black;
  } else {
    return Colors.transparent;
  }
}

String countryCodeToEmoji(String countryCode) {
  // 0x41 is Letter A
  // 0x1F1E6 is Regional Indicator Symbol Letter A
  // Example :
  // firstLetter U => 20 + 0x1F1E6
  // secondLetter S => 18 + 0x1F1E6
  // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}

List<Color> colors = [
  Color.fromARGB(255, 255, 101, 153),
  Colors.red,
  Colors.purple,
  Colors.indigo,
  Colors.lightBlue,
  Colors.green,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.brown,
  Color.fromARGB(255, 232, 195, 158),
  Colors.white,
  Colors.grey,
  Colors.black,
];

/// Crea la listView que carga todas las tapitas. Recibe la funcion cargaTapitas()
/// como callback (la llama y se ejecuta el setState)
ListView createListview(BuildContext context, List<Tapa> tapas,
    Function callback, List<String>? clausulas) {
  return ListView.builder(
      //shrinkWrap: true,
      //scrollDirection: Axis.vertical,
      itemCount: tapas.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) => Dismissible(
            key: Key(i.toString()),
            direction: DismissDirection.startToEnd,
            // background: Container(
            //     color: Colors.red,
            //     padding: EdgeInsets.only(left: 5),
            //     child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Icon(Icons.delete, color: Colors.white))),
            //secondaryBackground: Container(
            background: Container(
                color: Colors.blue,
                child: (Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.edit),
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
                context.read<TapaProvider>().brewery = tapas[i].brewery ?? "";
                context.read<TapaProvider>().brewCountry =
                    tapas[i].brewCountry ?? "";
                context.read<TapaProvider>().brewCountryCode =
                    tapas[i].brewCountryCode ?? "";
                context.read<TapaProvider>().tapaAsString =
                    tapas[i].imagen ?? "";
                context.read<TapaProvider>().type = tapas[i].type ?? "";
                context.read<TapaProvider>().model = tapas[i].model ?? "";
                context.read<TapaProvider>().place = tapas[i].place ?? "";
                context.read<TapaProvider>().date = tapas[i].date ?? "";
                context.read<TapaProvider>().color1 =
                    stringToColor(tapas[i].primColor ?? "");
                context.read<TapaProvider>().color2 =
                    stringToColor(tapas[i].secoColor ?? "");

                Navigator.pushNamed(context, "/formtapa",
                        arguments: tapas[i].id)
                    .then((_) => (clausulas == null
                        ? callback(lastOrderMethod)
                        : callback(clausulas)));
              } else {
                // return await _showConfirmationDialogToDeleteTapa(
                //     context, i, tapas, callback);
                return null;
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
                      text: tapas[i].model,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                        text: tapas[i].brewCountryCode!.isEmpty
                            ? ""
                            : " ${countryCodeToEmoji(tapas[i].brewCountryCode!)}"),
                    TextSpan(
                      text: tapas[i].type!.isEmpty ? "" : " - ${tapas[i].type}",
                    ),
                    TextSpan(
                        text: tapas[i].rating == 0.0
                            ? ""
                            : "- ${tapas[i].rating}"),
                  ],
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: MemoryImage(base64Decode(tapas[i].imagen!)),
                radius: 30.0,
              ),
              subtitle: tapas[i].place!.isEmpty
                  ? Text("Drunk ${tapas[i].date}")
                  : Text("Drunk ${tapas[i].date} \nin ${tapas[i].place}"),
              isThreeLine: true,
              trailing: IconButton(
                  onPressed: () {
                    // if (tapas[i].isFavorited == 0) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: const Text("Added to favs"),
                    //     showCloseIcon: true,
                    //     duration: Duration(seconds: 1),
                    //   ));
                    //   DB.updateFavorite(1, tapas[i].id);
                    //   callback(lastOrderMethod);
                    // } else if (tapas[i].isFavorited == 1) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: const Text("Removed from favs"),
                    //     showCloseIcon: true,
                    //     duration: Duration(seconds: 1),
                    //   ));
                    //   DB.updateFavorite(0, tapas[i].id);
                    //   callback(lastOrderMethod);
                    // }
                  },
                  icon: tapas[i].isFavorited == 0
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite)),
              iconColor: tapas[i].isFavorited == 0 ? Colors.grey : Colors.red,
              onTap: () {
                alertTapa(context, tapas[i].imagen!, dialog: 'tapas');
              },
              dense: false,
              horizontalTitleGap: 10,
              splashColor: Colors.amber,
            ),
          ));
}

/// Crea el alert de confirmDismiss que debe retornar un bool
// Future<bool?> _showConfirmationDialogToDeleteTapa(
//     BuildContext context, int i, List<Tapa> tapas, Function callback) {
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Eliminar"),
//         content: Text("¿Está seguro de querer eliminar la tapa?"),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 //MiLista().setState(() {});
//               },
//               child: Text("Cancelar")),
//           TextButton(
//               onPressed: () {
//                 DB.delete(tapas[i]);
//                 Navigator.pop(context);
//                 callback(lastOrderMethod);
//               },
//               child: Text("Eliminar"))
//         ],
//       );
//     },
//   );
// }

/// AlertDialog para la busqueda de tapas
/// dialog = 0 -> Busqueda de tapas (alertBusqueda)
///        = 1 -> Zoom tapa (alertTapa)
alertTapa(BuildContext context, String tapaAsString, {required String dialog}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              //elevation: 10,
              shape: CircleBorder(),
              content: SizedBox(
                  height: 250,
                  width: 250,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(tapaAsString)),
                      radius: 200.0,
                    ),
                  )),
            ),
          ));
}

Widget pickerLayoutBuilder(
    BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 300,
    //height: orientation == Orientation.portrait ? 360 : 240,
    height: 280,
    child: GridView.count(
      //crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
      crossAxisCount: 4,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: [for (Color color in colors) child(color)],
    ),
  );
}

Widget pickerItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: color,
      boxShadow: [
        BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1, 2),
            blurRadius: 5)
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: 24,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}

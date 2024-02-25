import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/screens/formTapa/widgets/brewery_row/brewery.dart';
import 'package:tappitas/screens/formTapa/widgets/colors_row/colors.dart';
import 'package:tappitas/screens/formTapa/widgets/photo_row/photo.dart';
import 'package:tappitas/screens/formTapa/widgets/type_model_row/type_model.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

import 'package:tappitas/utilities.dart';

import 'widgets/drunk_at_row/drunk_at.dart';

//Clase que representa la pantalla con el formulario que se ve al querer crear
//o editar una tapa
class CreaTapaExpandable extends StatefulWidget {
  CreaTapaExpandable({super.key});
  @override
  State<CreaTapaExpandable> createState() => _CreaTapaExpandableState();
}

class _CreaTapaExpandableState extends State<CreaTapaExpandable> {
  late Tapa tapa;

  double lastRating = 0.0;
  bool isFavorited = false;

  /// Funcion encargada de actualizar los campos de la tapa
  actualizaTapa(Tapa tapita) {
    tapa = tapita;

    setState(() {
      Provider.of<TapaProvider>(context, listen: false).brewery = tapa.brewery;
      Provider.of<TapaProvider>(context, listen: false).brewCountry =
          tapa.brewCountry;
      Provider.of<TapaProvider>(context, listen: false).brewCountryCode =
          tapa.brewCountryCode;
      Provider.of<TapaProvider>(context, listen: false).tapaAsString =
          tapa.imagen;
      Provider.of<TapaProvider>(context, listen: false).type = tapa.type;
      Provider.of<TapaProvider>(context, listen: false).model = tapa.model;
      Provider.of<TapaProvider>(context, listen: false).place = tapa.place;
      Provider.of<TapaProvider>(context, listen: false).date = tapa.date;
      Provider.of<TapaProvider>(context, listen: false).color1 =
          stringToColor(tapa.primColor);
      Provider.of<TapaProvider>(context, listen: false).color2 =
          stringToColor(tapa.secoColor);

      isFavorited = tapa.isFavorited == 0 ? false : true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      actualizaTapa(ModalRoute.of(context)!.settings.arguments as Tapa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tappa",
            style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 1.4),
        actions: [
          deleteTapa(),
        ],
      ),
      floatingActionButton: fabToSaveTapa(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList.radio(
              initialOpenPanelValue: 1,
              animationDuration: const Duration(milliseconds: 500),
              children: [
                customExpandablePanel(
                    name: "Photo",
                    value: 1,
                    clausule1: "tapaAsStringBase64",
                    body: PhotoRow()),
                customExpandablePanel(
                    name: "Brewery",
                    value: 2,
                    clausule1: "Text",
                    body: BreweryRow()),
                customExpandablePanel(
                    name: "Type & Model",
                    value: 3,
                    clausule1: "clausule1",
                    body: TypeModelRow()),
                customExpandablePanel(
                    name: "Drinked @",
                    value: 4,
                    clausule1: "clausule1",
                    body: DrinkedAtRow()),
                customExpandablePanel(
                    name: "Colors",
                    value: 5,
                    clausule1: "clausule1",
                    body: ColorsRow()),

                // ExpansionPanelRadio(
                //   value: 6,
                //   //isExpanded: _isOpen[3],
                //   canTapOnHeader: true,
                //   headerBuilder: ((context, isExpanded) => ListTile(
                //         title: Text("Rate tappa"),
                //       )),
                //   body:

                //       /// Rating row
                //       Row(children: [
                //     Expanded(
                //         child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //           Row(children: [
                //             sliderWidget(lastRating, context),
                //             IconButton(
                //                 color: Colors.red,
                //                 tooltip: "Favorite",
                //                 icon: isFavorited
                //                     ? const Icon(Icons.favorite)
                //                     : const Icon(Icons.favorite_border_outlined),
                //                 onPressed: () {
                //                   setState(() {
                //                     isFavorited = !isFavorited;
                //                   });
                //                 })
                //           ]),
                //         ])),
                //   ]),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderWidget(double sliderRating, BuildContext context) {
    //double myRating = 1.5;
    return SizedBox(
      width: 300,
      child: Slider.adaptive(
        value: sliderRating,
        onChanged: (newRating) => setState(() => sliderRating = newRating),
        min: 0,
        max: 5,
        divisions: 10,
        label: "$sliderRating",
        activeColor: Colors.amber,
        secondaryActiveColor: Colors.white,
      ),
    );
  }

  /// FAB para guardar la tapa
  Widget fabToSaveTapa() {
    return FloatingActionButton.extended(
        onPressed: () {
          if (Provider.of<TapaProvider>(context, listen: false)
              .tapaAsString
              .isNotEmpty) {
            if (tapa.id! > 0) {
              tapa.imagen = Provider.of<TapaProvider>(context, listen: false)
                  .tapaAsString;
              tapa.brewery = Provider.of<TapaProvider>(context, listen: false)
                  .brewery
                  .trim();
              tapa.primColor = colorToString(
                  Provider.of<TapaProvider>(context, listen: false).color1);
              tapa.secoColor = colorToString(
                  Provider.of<TapaProvider>(context, listen: false).color2);
              tapa.date =
                  Provider.of<TapaProvider>(context, listen: false).date;
              tapa.place = Provider.of<TapaProvider>(context, listen: false)
                  .place
                  .trim();
              tapa.brewCountry =
                  Provider.of<TapaProvider>(context, listen: false).brewCountry;
              tapa.brewCountryCode =
                  Provider.of<TapaProvider>(context, listen: false)
                      .brewCountryCode;
              //tapa.type = selectedType.contains('?') ? "" : selectedType;
              tapa.type = Provider.of<TapaProvider>(context, listen: false)
                      .type
                      .contains('?')
                  ? ""
                  : Provider.of<TapaProvider>(context, listen: false).type;
              tapa.isFavorited = isFavorited ? 1 : 0;
              tapa.rating = lastRating;
              tapa.model = Provider.of<TapaProvider>(context, listen: false)
                  .model
                  .trim();
              DB.update(tapa);
            } else {
              DB.insert(Tapa(
                  imagen: Provider.of<TapaProvider>(context, listen: false)
                      .tapaAsString,
                  brewery: Provider.of<TapaProvider>(context, listen: false)
                      .brewery
                      .trim(),
                  primColor: colorToString(
                      Provider.of<TapaProvider>(context, listen: false).color1),
                  secoColor: colorToString(
                      Provider.of<TapaProvider>(context, listen: false).color2),
                  date: Provider.of<TapaProvider>(context, listen: false).date,
                  place: Provider.of<TapaProvider>(context, listen: false)
                      .place
                      .trim(),
                  brewCountry: Provider.of<TapaProvider>(context, listen: false)
                      .brewCountry,
                  brewCountryCode:
                      Provider.of<TapaProvider>(context, listen: false)
                          .brewCountryCode,
                  type: Provider.of<TapaProvider>(context, listen: false)
                          .type
                          .contains('?')
                      ? ""
                      : Provider.of<TapaProvider>(context, listen: false).type,
                  isFavorited: isFavorited ? 1 : 0,
                  rating: lastRating,
                  model: Provider.of<TapaProvider>(context, listen: false)
                      .model
                      .trim()));
            }
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You must provide a photo"),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        label: Text("Save"),
        icon: Icon(Icons.save));
  }

  /// Boton de la appbar para borrar la tapa
  Widget deleteTapa() {
    return TextButton.icon(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context2) {
              return AlertDialog(
                title: Text("Delete"),
                content: Text("Delete tappa?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context2);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        DB.delete(tapa);
                        Navigator.pop(context);
                        Navigator.pop(context2);
                      },
                      child: Text("Delete"))
                ],
              );
            },
          );
        },
        icon: Icon(Icons.delete),
        label: Text('DELETE'));
  }
}

ExpansionPanel customExpandablePanel(
    {required String name,
    required int value,
    required String clausule1,
    String? clausule2,
    required Widget body}) {
  return ExpansionPanelRadio(
      canTapOnHeader: true,
      value: value,
      headerBuilder: ((context, isExpanded) => ListTile(
            title: Text(name),
            leading: clausule1.isEmpty ? Icon(Icons.close) : Icon(Icons.done),
          )),
      body: Padding(padding: const EdgeInsets.all(8), child: body));
}

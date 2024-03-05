// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/screens/formTapa/widgets/brewery_row/brewery.dart';
import 'package:tappitas/screens/formTapa/widgets/colors_row/colors.dart';
import 'package:tappitas/screens/formTapa/widgets/photo_row/photo.dart';
import 'package:tappitas/screens/formTapa/widgets/type_model_row/type_model.dart';
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
  late Id id;

  double lastRating = 0.0;
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      id = ModalRoute.of(context)?.settings.arguments as int;
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
        onPressed: () async {
          if (context.read<TapaProvider>().tapaAsString.isNotEmpty) {
            final isar = Isar.getInstance();

            final newTapa = Tapa()
              ..brewCountry = context.read<TapaProvider>().brewCountry
              ..brewCountryCode = context.read<TapaProvider>().brewCountryCode
              ..brewery = context.read<TapaProvider>().brewery
              ..date = context.read<TapaProvider>().date
              ..imagen = context.read<TapaProvider>().tapaAsString
              ..model = context.read<TapaProvider>().model
              ..place = context.read<TapaProvider>().place
              ..primColor = colorToString(context.read<TapaProvider>().color1)
              ..rating = context.read<TapaProvider>().rating
              ..secoColor = colorToString(context.read<TapaProvider>().color2)
              ..type = context.read<TapaProvider>().type.contains('?')
                  ? ""
                  : context.read<TapaProvider>().type;

            if (id != 0) newTapa.id = id;

            await isar!.writeTxn(() async {
              await isar.tapas.put(newTapa); // insert & update
            });
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
                      onPressed: () async {
                        final isar = Isar.getInstance();
                        await isar!.writeTxn(() async {
                          await isar.tapas.delete(id); // insert & update
                        });
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

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappitas/utilities.dart';

class DialogSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
  var pickFirstColor = Colors.transparent;
  var pickSecondColor = Colors.transparent;

  int _portraitCrossAxisCount = 3;
  int _landscapeCrossAxisCount = 4;
  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  void changeSecondColor(Color color) {
    setState(() => pickSecondColor = color);
  }

  void changeFirstColor(Color color) {
    setState(() => pickFirstColor = color);
  }

  final typeController = TextEditingController();
  final marController = TextEditingController();
  final paiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Search", style: GoogleFonts.aladin(), textScaleFactor: 2),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: marController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Brewery'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: paiController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Country'),
                      readOnly: true,
                      onTap: () => showCountryPicker(
                          context: context,
                          onSelect: (Country country) {
                            paiController.text = country.name;
                          },
                          favorite: <String>['ES', 'DE', 'BE']),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'Type'),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            //minimumSize: Size(160, 60),
                            shape: ContinuousRectangleBorder(),
                            side: BorderSide(color: Colors.white, width: 0.5),
                            backgroundColor: pickFirstColor,
                            foregroundColor: pickFirstColor == Colors.white
                                ? Colors.black
                                : Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select a color'),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    pickerColor: pickFirstColor,
                                    onColorChanged: changeFirstColor,
                                    availableColors: colors,
                                    layoutBuilder: pickerLayoutBuilder,
                                    itemBuilder: pickerItemBuilder,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text("1st color"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            //minimumSize: Size(160, 60),
                            shape: ContinuousRectangleBorder(),
                            side: BorderSide(color: Colors.white, width: 0.5),
                            backgroundColor: pickSecondColor,
                            foregroundColor: pickSecondColor == Colors.white
                                ? Colors.black
                                : Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select a color'),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    pickerColor: pickSecondColor,
                                    onColorChanged: changeSecondColor,
                                    availableColors: colors,
                                    layoutBuilder: pickerLayoutBuilder,
                                    itemBuilder: pickerItemBuilder,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('2nd color'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        padding: EdgeInsets.only(left: 50, right: 50)),
                    onPressed: () {
                      getClausule(
                        context,
                        marController.text,
                        typeController.text,
                        paiController.text,
                        colorToString(pickFirstColor),
                        colorToString(pickSecondColor),
                      );
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget pickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: orientation == Orientation.portrait ? 360 : 240,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait
            ? _portraitCrossAxisCount
            : _landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: color,
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1, 2),
              blurRadius: _blurRadius)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: _iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
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

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/screens/formTapa/widgets/type_model_row/type_model.dart';
import 'package:tappitas/utilities.dart';

class DialogSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
  var pickFirstColor = Colors.transparent;
  var pickSecondColor = Colors.transparent;

  void changeSecondColor(Color color) {
    setState(() => pickSecondColor = color);
  }

  void changeFirstColor(Color color) {
    setState(() => pickFirstColor = color);
  }

  String selectedType = "";
  final brewController = TextEditingController();
  final brewCountryController = TextEditingController();
  final placeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Search",
                style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 2),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    autofocus: true,
                    controller: brewController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Brewery/Model'),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: brewCountryController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Country'),
                    readOnly: true,
                    onTap: () => showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          brewCountryController.text = country.name;
                        },
                        favorite: <String>['ES', 'DE', 'BE']),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: "Date"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                    flex: 4, child: dropDownBeerTypes(context, selectedType)),
              ],
            ),
            SizedBox(height: 15),
            TextField(
              controller: placeController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.near_me),
                labelText: 'Place',
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      //minimumSize: Size(160, 60),
                      shape: ContinuousRectangleBorder(),
                      side: BorderSide(
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          width: 0.5),
                      backgroundColor: pickFirstColor,
                    ),
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
                      side: BorderSide(
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          width: 0.5),
                      backgroundColor: pickSecondColor,
                    ),
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  // style: OutlinedButton.styleFrom(
                  //     padding: EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  // style: FilledButton.styleFrom(
                  //     padding: EdgeInsets.only(left: 50, right: 50)),
                  onPressed: () {
                    getClausule(
                      context,
                      brewController.text.trim(),
                      brewCountryController.text,
                      selectedType,
                      dateController.text,
                      placeController.text.trim(),
                      colorToString(pickFirstColor),
                      colorToString(pickSecondColor),
                    );
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ]),
    );
  }

  /// Crea la clausula para la busqueda en la bbdd
  void getClausule(BuildContext context, String marC, String paiC, String tipC,
      String dateC, String placeC, String fgColC, String bgColC) {
    List<String> myList = [marC, paiC, tipC, dateC, placeC, fgColC, bgColC];
    print("myList: $myList");
    Navigator.popAndPushNamed(context, '/busqtapa', arguments: myList);
  }

  Widget dropDownBeerTypes(BuildContext context, String valor) {
    if (valor.isEmpty) valor = "?";

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Type'),
        isDense: true,
        //hintText: 'Marca',
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      value: valor,
      isExpanded: true,
      //elevation: 16,
      //style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (String? value) {
        setState(() {
          valor = value!;
          selectedType = valor;
        });
      },
      items: typesOfBeer.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

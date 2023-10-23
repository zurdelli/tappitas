import 'dart:convert';
//import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/screens/formTapa/widgets/brewery_row/brewery.dart';

import 'package:tappitas/screens/formTapa/widgets/photo_row/select_photo_options_screen.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart' as geocoding_package;

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tappitas/utilities.dart';

//Clase que representa la pantalla con el formulario que se ve al querer crear
//una tapa
class CreaTapaExpandable extends StatefulWidget {
  CreaTapaExpandable({super.key});

  @override
  State<CreaTapaExpandable> createState() => _CreaTapaExpandableState();
}

const List<String> typesOfBeer = <String>[
  '?',
  'Lager',
  'Ale',
  'Weiss',
  'IPA/APA',
  'Stout',
  'Red',
  'Alcohol Free',
  'Soft Drink',
  'Cider',
  'Other'
];

class _CreaTapaExpandableState extends State<CreaTapaExpandable> {
  late Tapa tapa;

  String tapaAsStringBase64 = "";
  String selectedType = "";
  String selectedCountry = "";
  String selectedCountryCode = "";

  int openRadio = 1;
  double lastRating = 0.0;

  int _portraitCrossAxisCount = 3;
  int _landscapeCrossAxisCount = 4;
  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  Color pickFirstColor = Colors.transparent;
  Color pickSecondColor = Colors.transparent;

  void changeFirstColor(Color color) {
    setState(() => pickFirstColor = color);
  }

  void changeSecondColor(Color color) {
    setState(() => pickSecondColor = color);
  }

  //final primColorController = TextEditingController();
  //final secoColorController = TextEditingController();

  bool isFavorited = false;

  final breweryController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();
  final placeController = TextEditingController();
  final brewCountryController = TextEditingController();
  final modelController = TextEditingController();

  /// Funcion encargada de actualizar los campos de la tapa
  actualizaTapa(Tapa tapita) {
    tapa = tapita;

    setState(() {
      if (tapaAsStringBase64.isEmpty) {
        tapaAsStringBase64 = tapa.imagen;
      }

      if (selectedType.isEmpty) {
        selectedType = tapa.type;
      }

      isFavorited = tapa.isFavorited == 0 ? false : true;
      modelController.text = tapa.model;
      placeController.text = tapa.place;
      breweryController.text = tapa.brewery;
      dateController.text = tapa.date;
      brewCountryController.text =
          "${tapa.brewCountry} ${tapa.brewCountryCode}";

      if (tapa.primColor.isNotEmpty) {
        pickFirstColor = stringToColor(tapa.primColor);
      }

      if (tapa.secoColor.isNotEmpty) {
        pickSecondColor = stringToColor(tapa.secoColor);
      }

      //lastRating = tapa.rating;
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
          TextButton.icon(
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
              label: Text('DELETE'))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (tapaAsStringBase64.isNotEmpty) {
              if (tapa.id! > 0) {
                tapa.imagen = tapaAsStringBase64;
                tapa.brewery = breweryController.text;
                tapa.primColor = colorToString(pickFirstColor);
                tapa.secoColor = colorToString(pickSecondColor);
                tapa.date = dateController.text;
                tapa.place = placeController.text;
                tapa.brewCountry = brewCountryController.text.isNotEmpty
                    ? brewCountryController.text
                        .substring(0, brewCountryController.text.length - 5)
                    : "";
                tapa.brewCountryCode = brewCountryController.text.isNotEmpty
                    ? brewCountryController.text
                        .substring(brewCountryController.text.length - 4)
                    : "";
                tapa.type = selectedType.contains('?') ? "" : selectedType;
                tapa.isFavorited = isFavorited ? 1 : 0;
                tapa.rating = lastRating;
                tapa.model = modelController.text;
                DB.update(tapa);
              } else {
                DB.insert(Tapa(
                    imagen: tapaAsStringBase64,
                    brewery: breweryController.text,
                    primColor: colorToString(pickFirstColor),
                    secoColor: colorToString(pickSecondColor),
                    date: dateController.text,
                    place: placeController.text,
                    brewCountry: brewCountryController.text.length > 1
                        ? brewCountryController.text
                            .substring(0, brewCountryController.text.length - 5)
                        : "",
                    brewCountryCode: brewCountryController.text.length > 1
                        ? brewCountryController.text
                            .substring(brewCountryController.text.length - 4)
                        : "",
                    type: selectedType.contains('?') ? "" : selectedType,
                    isFavorited: isFavorited ? 1 : 0,
                    rating: lastRating,
                    model: modelController.text));
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
          icon: Icon(Icons.save)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList.radio(
              initialOpenPanelValue: 1,
              animationDuration: const Duration(milliseconds: 500),
              //expansionCallback: (int index, bool isExpanded) {},
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  canTapOnHeader: true,
                  //isExpanded: _isOpen[0],
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text("Photo"),
                        leading: tapaAsStringBase64.isEmpty
                            ? Icon(Icons.close)
                            : Icon(Icons.done),
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _showSelectPhotoOptions(context),
                        child: Center(
                          child: Container(
                            height: 160.0,
                            width: 160.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: tapaAsStringBase64.isEmpty
                                  ? const Text(
                                      'No image selected',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: MemoryImage(
                                          base64Decode(tapaAsStringBase64)),
                                      radius: 200.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  //isExpanded: _isOpen[1],
                  value: 2,
                  canTapOnHeader: true,
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text("Brewery"),
                        leading: brewCountryController.text.isNotEmpty &&
                                breweryController.text.isNotEmpty
                            ? Icon(Icons.done)
                            : Icon(Icons.remove),
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: breweryRow(breweryController, brewCountryController,
                        context, selectedCountry, selectedCountryCode),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 3,
                  //isExpanded: _isOpen[2],
                  canTapOnHeader: true,
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text("Type & Model"),
                        leading: selectedType.isNotEmpty
                            ? Icon(Icons.done)
                            : Icon(Icons.remove),
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      /// Model & Type
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: dropDownBeerTypes(context, selectedType),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: modelController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Model (optional)'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  //isExpanded: _isOpen[4],

                  canTapOnHeader: true,
                  value: 4,
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text("Drinked @"),
                        leading: dateController.text.isNotEmpty &&
                                placeController.text.isNotEmpty
                            ? Icon(Icons.done)
                            : Icon(Icons.remove),
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // Drinked @ row
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // Text.rich(TextSpan(
                              //     style: TextStyle(fontSize: 20), text: 'Drinked @')),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: dateController,
                                decoration: InputDecoration(
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
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: placeController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.near_me),
                                  suffixIcon: IconButton(
                                    color: Colors.blue,
                                    //alignment: Alignment.centerRight,
                                    icon: Icon(Icons.gps_fixed),
                                    onPressed: () {
                                      getLocation();
                                    },
                                  ),
                                  labelText: 'Place',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  // Colors
                  //isExpanded: _isOpen[5],
                  canTapOnHeader: true,
                  value: 5,
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text("Colors"),
                        leading: pickFirstColor != Colors.transparent &&
                                pickSecondColor != Colors.transparent
                            ? Icon(Icons.done)
                            : Icon(Icons.remove),
                      )),
                  body: Padding(
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
                                side: BorderSide(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    width: 0.5),
                                backgroundColor: pickFirstColor,
                                foregroundColor:
                                    pickFirstColor == Colors.white ||
                                            MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
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
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(child: Icon(Icons.color_lens)),
                                  TextSpan(
                                      text:
                                          colorToString(pickFirstColor).isEmpty
                                              ? '1st color'
                                              : colorToString(pickFirstColor))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                //minimumSize: Size(160, 60),
                                shape: ContinuousRectangleBorder(),
                                side: BorderSide(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    width: 0.5),
                                backgroundColor: pickSecondColor,
                                foregroundColor:
                                    pickSecondColor == Colors.white ||
                                            MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
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
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(child: Icon(Icons.color_lens)),
                                  TextSpan(
                                      text:
                                          colorToString(pickSecondColor).isEmpty
                                              ? '2nd color'
                                              : colorToString(pickSecondColor))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            // SizedBox(height: 15),
            // OutlinedButton(
            //     style: OutlinedButton.styleFrom(
            //       //minimumSize: Size(30, 50),
            //       backgroundColor: Colors.red,
            //       foregroundColor: Colors.white,
            //       textStyle:
            //           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            //       padding: EdgeInsetsDirectional.symmetric(
            //           horizontal: 50, vertical: 10),
            //     ),
            //     onPressed: () {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context2) {
            //           return AlertDialog(
            //             title: Text("Delete?"),
            //             actions: [
            //               TextButton(
            //                   onPressed: () {
            //                     Navigator.pop(context2);
            //                   },
            //                   child: Text("Cancel")),
            //               TextButton(
            //                   onPressed: () {
            //                     DB.delete(tapa);
            //                     Navigator.pop(context);
            //                     Navigator.pop(context2);
            //                   },
            //                   child: Text("Delete"))
            //             ],
            //           );
            //         },
            //       );
            //     },
            //     child: const Text('Delete')),
          ],
        ),

        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => MyColorPicker()));
        //     },
        //     child: Text("Cliqueame")),
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

  Widget dropDownBeerTypes(BuildContext context, String valor) {
    if (valor.isEmpty) valor = "?";

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        //label: Text('Type'),
        //hintText: 'Marca',
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      value: valor,
      elevation: 16,
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

  Future getLocation() async {
    location_package.Location location = location_package.Location();

    bool serviceEnabled;
    location_package.PermissionStatus permissionGranted;
    location_package.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == location_package.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != location_package.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    //print("La latitud es: ${locationData.latitude}");
    double latitud = locationData.latitude ?? 0;
    double longitud = locationData.longitude ?? 0;

    List<geocoding_package.Placemark> placemarks =
        await geocoding_package.placemarkFromCoordinates(latitud, longitud);

    String place = "${placemarks[0].locality}, ${placemarks[0].country}";

    placeController.text = place;
    //return place;
  }

  /// image picker
  Future _pickImage(ImageSource source) async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (image == null) return;

      File? img = File(image.path);
      img = await _cropImage(img); // la llevo al cropper
    } on PlatformException catch (e) {
      print("exception: $e");
      Navigator.pop(context);
    }
  }

  // image cropper
  Future _cropImage(File imageFile) async {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
          toolbarWidgetColor:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? Colors.black
                  : Colors.white),
      IOSUiSettings(title: 'Crop')
    ]);

    if (cropped != null) {
      setState(() {
        imageFile = File(cropped.path);
        tapaAsStringBase64 = base64Encode(imageFile.readAsBytesSync());
        //print("tapaAsStringBase64: $tapaAsStringBase64");
        Navigator.of(context).pop();
      });
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
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
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tappitas/provider/slider_provider.dart';
// import 'package:tappitas/screens/formTapa/widgets/color_picker/color_picker.dart';

// import 'package:tappitas/screens/formTapa/widgets/photo_row/select_photo_options_screen.dart';

// import 'package:tappitas/db.dart';
// import 'package:tappitas/models/tapa.dart';

// import 'package:location/location.dart' as location_package;
// import 'package:geocoding/geocoding.dart' as geocoding_package;
// import 'package:tappitas/screens/formTapa/widgets/slider_widget.dart';

// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:country_picker/country_picker.dart';

// //Clase que representa la pantalla con el formulario que se ve al querer crear
// //una tapa
// class CreaTapa extends StatefulWidget {
//   CreaTapa({super.key});

//   // Se debe crear una unica global key que identifica al form dentro de la app
//   static final _formKey = GlobalKey<FormState>();

//   @override
//   State<CreaTapa> createState() => _CreaTapaState();
// }

// const List<String> listaTipos = <String>[
//   'Lager',
//   'Red',
//   'Weiss',
//   'IPA/APA',
//   'Black',
//   'Tostada',
//   'Alcohol Free',
//   'Soft Drink',
//   'Other'
// ];

// const List<Color> colors = [
//   Colors.red,
//   Colors.purple,
//   Colors.indigo,
//   Colors.lightBlue,
//   Colors.green,
//   Colors.yellow,
//   Colors.amber,
//   Colors.orange,
//   Colors.brown,
//   Colors.white,
//   Colors.grey,
//   Colors.black,
// ];

// class _CreaTapaState extends State<CreaTapa> {
//   late Tapa tapa;

//   String tapaAsStringBase64 = "";
//   String selectedType = "";
//   String selectedCountry = "";
//   String selectedCountryCode = "";
//   double lastRating = 0.0;

//   int _portraitCrossAxisCount = 3;
//   int _landscapeCrossAxisCount = 4;
//   double _borderRadius = 30;
//   double _blurRadius = 5;
//   double _iconSize = 24;

//   Color pickerColor = Colors.transparent;

//   void changeColor(Color color) {
//     setState(() => pickerColor = color);
//   }

//   bool isFavorited = false;

//   final breweryController = TextEditingController();
//   final dateController = TextEditingController();
//   final primColorController = TextEditingController();
//   final secoColorController = TextEditingController();
//   final typeController = TextEditingController();
//   final placeController = TextEditingController();
//   final brewCountryController = TextEditingController();
//   final modelController = TextEditingController();

//   /// Funcion encargada de actualizar los campos de la tapa
//   actualizaTapa(Tapa tapita) {
//     tapa = tapita;

//     setState(() {
//       if (tapaAsStringBase64.isEmpty) {
//         tapaAsStringBase64 = tapa.imagen;
//       }

//       if (selectedType.isEmpty) {
//         selectedType = tapa.type;
//       }

//       if (tapa.isFavorited == 0) {
//         isFavorited = false;
//       } else {
//         isFavorited = true;
//       }

//       breweryController.text = tapa.brewery;
//       dateController.text = tapa.date;
//       if (tapa.primColor.isNotEmpty) {
//         pickerColor = stringToColor(tapa.primColor);
//       }

//       placeController.text = tapa.place;
//       selectedCountry = tapa.brewCountry;
//       selectedCountryCode = tapa.brewCountryCode;
//       modelController.text = tapa.model;
//       lastRating = tapa.rating;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       actualizaTapa(ModalRoute.of(context)!.settings.arguments as Tapa);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final myLastRating = Provider.of<SliderProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Tapa"),
//         actions: [
//           TextButton.icon(
//               style: ButtonStyle(
//                   foregroundColor:
//                       MaterialStateColor.resolveWith((states) => Colors.white)),
//               onPressed: () {
//                 if (CreaTapa._formKey.currentState!.validate() &&
//                     tapaAsStringBase64.isNotEmpty) {
//                   if (tapa.id! > 0) {
//                     tapa.imagen = tapaAsStringBase64;
//                     tapa.brewery = breweryController.text;
//                     tapa.primColor = colorToString(pickerColor);
//                     tapa.secoColor = colorToString(pickerColor);
//                     tapa.date = dateController.text;
//                     tapa.place = placeController.text;
//                     tapa.brewCountry = selectedCountry;
//                     tapa.brewCountryCode = selectedCountryCode;
//                     tapa.type = selectedType;
//                     tapa.isFavorited = isFavorited ? 1 : 0;
//                     tapa.rating = myLastRating.value;
//                     tapa.model = modelController.text;
//                     DB.update(tapa);
//                   } else {
//                     DB.insert(Tapa(
//                         imagen: tapaAsStringBase64,
//                         brewery: breweryController.text,
//                         primColor: colorToString(pickerColor),
//                         secoColor: colorToString(pickerColor),
//                         date: dateController.text,
//                         place: placeController.text,
//                         brewCountry: selectedCountry,
//                         brewCountryCode: selectedCountryCode,
//                         type: selectedType,
//                         isFavorited: isFavorited ? 1 : 0,
//                         rating: myLastRating.value,
//                         model: modelController.text));
//                   }
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text("You must provide a photo"),
//                     showCloseIcon: true,
//                     behavior: SnackBarBehavior.floating,
//                   ));
//                 }
//               },
//               icon: Icon(Icons.save),
//               label: Text('SAVE'))
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: CreaTapa._formKey,
//           child: Column(
//             children: <Widget>[
//               /// Foto
//               Center(
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () => _showSelectPhotoOptions(context),
//                   child: Center(
//                     child: Container(
//                       height: 160.0,
//                       width: 160.0,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey.shade200,
//                       ),
//                       child: Center(
//                         child: tapaAsStringBase64.isEmpty
//                             ? const Text(
//                                 'No image selected',
//                                 style: TextStyle(
//                                     fontSize: 20, color: Colors.black),
//                               )
//                             : CircleAvatar(
//                                 backgroundImage: MemoryImage(
//                                     base64Decode(tapaAsStringBase64)),
//                                 radius: 200.0,
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),

//               /// Rating row
//               Row(children: [
//                 Expanded(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                       Text('Rating'),
//                       Row(children: [
//                         SliderWidget(),
//                         IconButton(
//                             color: Colors.red,
//                             tooltip: "Favorito",
//                             icon: isFavorited
//                                 ? const Icon(Icons.favorite)
//                                 : const Icon(Icons.favorite_border_outlined),
//                             onPressed: () {
//                               setState(() {
//                                 isFavorited = !isFavorited;
//                               });
//                             })
//                       ])
//                     ]))
//               ]),

//               ///Brewery row
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           //color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text.rich(TextSpan(
//                               style: TextStyle(fontSize: 20), text: 'Brewery')),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             controller: breweryController,
//                             textCapitalization: TextCapitalization.sentences,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Name',
//                               focusColor: Colors.black,
//                             ),
//                             // validator: (value) {
//                             //   if (value == null || value.isEmpty) {
//                             //     return 'Debes insertar texto';
//                             //   }
//                             //   return null;
//                             // }),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   prefixIcon: Icon(Icons.location_on),
//                                   labelText: "Country"),
//                               readOnly: true,
//                               onTap: () => showCountryPicker(
//                                   context: context,
//                                   onSelect: (Country country) {
//                                     selectedCountry =
//                                         country.nameLocalized ?? country.name;
//                                     selectedCountryCode = country.countryCode;
//                                   },
//                                   favorite: <String>['ES', 'DE'])),

//                           // GestureDetector(
//                           //   onTap: () => showCountryPicker(
//                           //       context: context,
//                           //       onSelect: (Country country) {
//                           //         selectedCountry =
//                           //             country.nameLocalized ?? country.name;
//                           //         selectedCountryCode = country.countryCode;
//                           //       },
//                           //       favorite: <String>['ES', 'DE']),
//                           //       child: Row(
//                           //         children: [
//                           //           Expanded(
//                           //             child: ),
//                           //         ],
//                           //       ),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10), Divider(), SizedBox(height: 10),

//               /// Model & Type
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         dropDownBeerTypes(context, selectedType),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           controller: modelController,
//                           textCapitalization: TextCapitalization.sentences,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(), labelText: 'Model'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10), Divider(), SizedBox(height: 10),

//               /// Drinked @ row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Text.rich(TextSpan(
//                               style: TextStyle(fontSize: 20),
//                               text: 'Drinked @')),
//                           TextField(
//                             controller: dateController,
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 icon: Icon(Icons.calendar_today),
//                                 labelText: "Date"),
//                             readOnly: true,
//                             onTap: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(2000),
//                                   lastDate: DateTime.now());
//                               if (pickedDate != null) {
//                                 print(
//                                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                                 String formattedDate =
//                                     DateFormat('dd-MM-yyyy').format(pickedDate);
//                                 print(
//                                     formattedDate); //formatted date output using intl package =>  2021-03-16
//                                 //you can implement different kind of Date Format here according to your requirement

//                                 setState(() {
//                                   dateController.text =
//                                       formattedDate; //set output date to TextField value.
//                                 });
//                               } else {
//                                 print("Date is not selected");
//                               }
//                             },
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width - (90),
//                                 child: TextFormField(
//                                   controller: placeController,
//                                   textCapitalization:
//                                       TextCapitalization.sentences,
//                                   decoration: InputDecoration(
//                                     icon: Icon(Icons.near_me),
//                                     labelText: 'Place',
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 //width: 50,
//                                 child: IconButton(
//                                   color: Colors.blue,
//                                   alignment: Alignment.centerRight,
//                                   icon: Icon(Icons.gps_fixed),
//                                   onPressed: () {
//                                     getLocation();
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10), Divider(), SizedBox(height: 10),

//               /// Colors row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: pickerColor,
//                         foregroundColor: pickerColor == Colors.white
//                             ? Colors.black
//                             : Colors.white),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: const Text('Select a color'),
//                             content: SingleChildScrollView(
//                               child: BlockPicker(
//                                 pickerColor: pickerColor,
//                                 onColorChanged: changeColor,
//                                 availableColors: colors,
//                                 layoutBuilder: pickerLayoutBuilder,
//                                 itemBuilder: pickerItemBuilder,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Text("1st color"),
//                   ),
//                   SizedBox(
//                     width: 150,
//                     child: TextField(
//                       controller: primColorController,
//                       textCapitalization: TextCapitalization.sentences,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.color_lens),
//                         label: Text("2nd Color"),
//                         border: UnderlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MyColorPicker()));
//                   },
//                   child: Text("Cliqueame")),

//               OutlinedButton(
//                   style: ElevatedButton.styleFrom(
//                       //minimumSize: Size(30, 50),
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       textStyle:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       padding: EdgeInsetsDirectional.symmetric(
//                           horizontal: 30, vertical: 10),
//                       shape: ContinuousRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       )),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context2) {
//                         return AlertDialog(
//                           title: Text("Eliminar"),
//                           content:
//                               Text("¿Está seguro de querer eliminar la tapa?"),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context2);
//                                 },
//                                 child: Text("Cancelar")),
//                             TextButton(
//                                 onPressed: () {
//                                   DB.delete(tapa);
//                                   Navigator.pop(context);
//                                   Navigator.pop(context2);
//                                 },
//                                 child: Text("Eliminar"))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: const Text('Delete')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget dropDownBeerTypes(BuildContext context, String valor) {
//     if (valor.isEmpty) valor = "Lager";

//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         label: Text('Type'),
//         //hintText: 'Marca',
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//       value: valor,
//       elevation: 16,
//       //style: const TextStyle(color: Colors.black, fontSize: 16),
//       onChanged: (String? value) {
//         setState(() {
//           valor = value!;
//           selectedType = valor;
//         });
//       },
//       items: listaTipos.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }

//   Future getLocation() async {
//     location_package.Location location = location_package.Location();

//     bool serviceEnabled;
//     location_package.PermissionStatus permissionGranted;
//     location_package.LocationData locationData;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == location_package.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != location_package.PermissionStatus.granted) {
//         return;
//       }
//     }

//     locationData = await location.getLocation();

//     //print("La latitud es: ${locationData.latitude}");
//     double latitud = locationData.latitude ?? 0;
//     double longitud = locationData.longitude ?? 0;

//     List<geocoding_package.Placemark> placemarks =
//         await geocoding_package.placemarkFromCoordinates(latitud, longitud);

//     String place = "${placemarks[0].locality}, ${placemarks[0].country}";

//     placeController.text = place;
//     //return place;
//   }

//   /// image picker
//   Future _pickImage(ImageSource source) async {
//     try {
//       final XFile? image =
//           await ImagePicker().pickImage(source: source, imageQuality: 100);
//       if (image == null) return;

//       File? img = File(image.path);
//       img = await _cropImage(img); // la llevo al cropper
//     } on PlatformException catch (e) {
//       print("exception: $e");
//       Navigator.pop(context);
//     }
//   }

//   // image cropper
//   Future _cropImage(File imageFile) async {
//     CroppedFile? cropped = await ImageCropper()
//         .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
//       CropAspectRatioPreset.square,
//     ], uiSettings: [
//       AndroidUiSettings(
//           toolbarTitle: 'Crop',
//           cropGridColor: Colors.black,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: true),
//       IOSUiSettings(title: 'Crop')
//     ]);

//     if (cropped != null) {
//       setState(() {
//         imageFile = File(cropped.path);
//         tapaAsStringBase64 = base64Encode(imageFile.readAsBytesSync());
//         //print("tapaAsStringBase64: $tapaAsStringBase64");
//         Navigator.of(context).pop();
//       });
//     }
//   }

//   void _showSelectPhotoOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25.0),
//         ),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//           initialChildSize: 0.28,
//           maxChildSize: 0.4,
//           minChildSize: 0.28,
//           expand: false,
//           builder: (context, scrollController) {
//             return SingleChildScrollView(
//               controller: scrollController,
//               child: SelectPhotoOptionsScreen(
//                 onTap: _pickImage,
//               ),
//             );
//           }),
//     );
//   }

//   Widget pickerLayoutBuilder(
//       BuildContext context, List<Color> colors, PickerItem child) {
//     Orientation orientation = MediaQuery.of(context).orientation;

//     return SizedBox(
//       width: 300,
//       height: orientation == Orientation.portrait ? 360 : 240,
//       child: GridView.count(
//         crossAxisCount: orientation == Orientation.portrait
//             ? _portraitCrossAxisCount
//             : _landscapeCrossAxisCount,
//         crossAxisSpacing: 5,
//         mainAxisSpacing: 5,
//         children: [for (Color color in colors) child(color)],
//       ),
//     );
//   }

//   Widget pickerItemBuilder(
//       Color color, bool isCurrentColor, void Function() changeColor) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(_borderRadius),
//         color: color,
//         boxShadow: [
//           BoxShadow(
//               color: color.withOpacity(0.8),
//               offset: const Offset(1, 2),
//               blurRadius: _blurRadius)
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: changeColor,
//           borderRadius: BorderRadius.circular(_borderRadius),
//           child: AnimatedOpacity(
//             duration: const Duration(milliseconds: 250),
//             opacity: isCurrentColor ? 1 : 0,
//             child: Icon(
//               Icons.done,
//               size: _iconSize,
//               color: useWhiteForeground(color) ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Translates color <-> string
//   String colorToString(Color color) {
//     if (color == Colors.red) {
//       return "Red";
//     } else if (color == Colors.purple) {
//       return "Purple";
//     } else if (color == Colors.indigo) {
//       return "Blue";
//     } else if (color == Colors.lightBlue) {
//       return "LightBlue";
//     } else if (color == Colors.green) {
//       return "Green";
//     } else if (color == Colors.yellow) {
//       return "Yellow";
//     } else if (color == Colors.amber) {
//       return "Gold";
//     } else if (color == Colors.orange) {
//       return "Orange";
//     } else if (color == Colors.brown) {
//       return "Brown";
//     } else if (color == Colors.white) {
//       return "White";
//     } else if (color == Colors.grey) {
//       return "Grey";
//     } else if (color == Colors.black) {
//       return "Black";
//     } else {
//       return "";
//     }
//   }

//   /// Translates color <-> string
//   Color stringToColor(String color) {
//     if (color == "Red") {
//       return Colors.red;
//     } else if (color == "Purple") {
//       return Colors.purple;
//     } else if (color == "Blue") {
//       return Colors.indigo;
//     } else if (color == "LightBlue") {
//       return Colors.lightBlue;
//     } else if (color == "Green") {
//       return Colors.green;
//     } else if (color == "Yellow") {
//       return Colors.yellow;
//     } else if (color == "Gold") {
//       return Colors.amber;
//     } else if (color == "Orange") {
//       return Colors.orange;
//     } else if (color == "Brown") {
//       return Colors.brown;
//     } else if (color == "White") {
//       return Colors.white;
//     } else if (color == "Grey") {
//       return Colors.grey;
//     } else if (color == "Black") {
//       return Colors.black;
//     } else {
//       return Colors.black;
//     }
//   }
// }

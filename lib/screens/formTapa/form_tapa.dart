import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//import 'package:tappitas/screens/formTapa/widgets/dropdown_types.dart';
import 'package:tappitas/screens/formTapa/select_photo_options_screen.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart' as geocoding_package;

//Clase que representa la pantalla con el formulario que se ve al querer crear
//una tapa
class CreaTapa extends StatefulWidget {
  CreaTapa({super.key});

  // Se debe crear una unica global key que identifica al form dentro de la app
  static final _formKey = GlobalKey<FormState>();

  @override
  State<CreaTapa> createState() => _CreaTapaState();
}

const List<String> listaTipos = <String>[
  'Lager',
  'Roja',
  'Trigo',
  'IPA/APA',
  'Negra',
  'Tostada',
  'Gaseosa/Refresco',
  'Sin alcohol',
  'Otras'
];

class _CreaTapaState extends State<CreaTapa> {
  late Tapa tapa;

  String tapaAsStringBase64 = "";
  String selectedType = "";
  double lastRating = 0.0;
  bool isFavorited = false;

  final marcaController = TextEditingController();
  final fechaController = TextEditingController();
  final fgColorController = TextEditingController();
  final bgColorController = TextEditingController();
  final tipoController = TextEditingController();
  final lugarController = TextEditingController();
  final paisController = TextEditingController();
  final modeloController = TextEditingController();

  /// Funcion encargada de actualizar los campos de la tapa
  actualizaTapa(Tapa tapita) {
    tapa = tapita;

    setState(() {
      if (tapaAsStringBase64.isEmpty) {
        tapaAsStringBase64 = tapa.imagen;
      }

      if (selectedType.isEmpty) {
        selectedType = tapa.tipo;
      }

      if (tapa.isFavorited == 0) {
        isFavorited = false;
      } else {
        isFavorited = true;
      }

      marcaController.text = tapa.marca;
      fechaController.text = tapa.fecha;
      fgColorController.text = tapa.fgColor;
      bgColorController.text = tapa.bgColor;
      lugarController.text = tapa.lugar;
      paisController.text = tapa.pais;
      modeloController.text = tapa.modelo;
      lastRating = tapa.rating;
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
        title: Text("Tapa"),
        actions: [
          IconButton(
            tooltip: "Favorito",
            icon: isFavorited
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
          ),
          IconButton(
            tooltip: "Eliminar",
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Eliminar"),
                    content: Text("¿Está seguro de querer eliminar la tapa?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar")),
                      TextButton(
                          onPressed: () {
                            DB.delete(tapa);
                            Navigator.popAndPushNamed(context, "/");
                          },
                          child: Text("Eliminar"))
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: CreaTapa._formKey,
          child: Column(
            children: <Widget>[
              /// Foto
              Center(
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
                                style: TextStyle(fontSize: 20),
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
              SizedBox(
                height: 10,
              ),

              /// Rating row
              Row(
                children: [
                  Expanded(
                    //width: 200,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rating'),
                        Slider.adaptive(
                          value: lastRating,
                          onChanged: (newRating) =>
                              {setState(() => lastRating = newRating)},
                          min: 0,
                          max: 5,
                          divisions: 10,
                          label: "$lastRating",
                          activeColor: Colors.amber,
                        ),
                      ],
                    ),
                  )
                ],
              ),

              /// Model & Type
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: modeloController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Model'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dropDownBeerTypes(context, selectedType)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), Divider(), SizedBox(height: 10),

              ///Brewery row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(
                              style: TextStyle(fontSize: 20), text: 'Brewery')),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: marcaController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              focusColor: Colors.black,
                            ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Debes insertar texto';
                            //   }
                            //   return null;
                            // }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: paisController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Country'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), Divider(), SizedBox(height: 10),

              /// Drinked @ row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Text.rich(TextSpan(
                              style: TextStyle(fontSize: 20),
                              text: 'Drinked @')),
                          TextField(
                            controller: fechaController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "¿Cuando se tomó?"),
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
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  fechaController.text =
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
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - (90),
                                child: TextFormField(
                                  controller: lugarController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.near_me),
                                    labelText: 'Lugar',
                                  ),
                                ),
                              ),
                              SizedBox(
                                //width: 50,
                                child: IconButton(
                                  color: Colors.blue,
                                  alignment: Alignment.centerRight,
                                  icon: Icon(Icons.gps_fixed),
                                  onPressed: () {
                                    getLocation();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), Divider(), SizedBox(height: 10),

              /// Colors row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: bgColorController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.color_lens_outlined),
                        border: UnderlineInputBorder(),
                        label: Text("1st Color"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: fgColorController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.color_lens),
                        label: Text("2nd Color"),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              /// Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/");
                      },
                      child: const Text('Cancelar')),
                  OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          //minimumSize: Size(30, 50),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {
                        if (CreaTapa._formKey.currentState!.validate()) {
                          if (tapa.id! > 0) {
                            tapa.imagen = tapaAsStringBase64;
                            tapa.marca = marcaController.text;
                            tapa.fgColor = fgColorController.text;
                            tapa.bgColor = bgColorController.text;
                            tapa.fecha = fechaController.text;
                            tapa.lugar = lugarController.text;
                            tapa.pais = paisController.text;
                            tapa.tipo = selectedType;
                            tapa.isFavorited = isFavorited ? 1 : 0;
                            tapa.rating = lastRating;
                            tapa.modelo = modeloController.text;
                            DB.update(tapa);
                          } else {
                            DB.insert(Tapa(
                                imagen: tapaAsStringBase64,
                                marca: marcaController.text,
                                fgColor: fgColorController.text,
                                bgColor: bgColorController.text,
                                fecha: fechaController.text,
                                lugar: lugarController.text,
                                pais: paisController.text,
                                tipo: selectedType,
                                isFavorited: isFavorited ? 1 : 0,
                                rating: lastRating,
                                modelo: modeloController.text));
                          }
                          Navigator.popAndPushNamed(context, "/");
                        }
                      },
                      child: const Text('Guardar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownBeerTypes(BuildContext context, String valor) {
    if (valor.isEmpty) valor = listaTipos.first;

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Type'),
        //hintText: 'Marca',
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      value: valor,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (String? value) {
        setState(() {
          valor = value!;
          selectedType = valor;
        });
      },
      items: listaTipos.map<DropdownMenuItem<String>>((String value) {
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

    lugarController.text = place;
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
          lockAspectRatio: true),
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
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

import 'package:tappitas/screens/formTapa/widgets/dropdown_types.dart';
import 'package:tappitas/screens/formTapa/select_photo_options_screen.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

//Clase que representa la pantalla con el formulario que se ve al querer crear
//una tapa
class CreaTapa extends StatefulWidget {
  CreaTapa({super.key});

  // Se debe crear una unica global key que identifica al form dentro de la app
  static final _formKey = GlobalKey<FormState>();

  @override
  State<CreaTapa> createState() => _CreaTapaState();
}

class _CreaTapaState extends State<CreaTapa> {
  String tapaAsStringBase64 = "";

  final nombreController = TextEditingController();

  final marcaController = TextEditingController();

  final fechaController = TextEditingController();

  final colorController = TextEditingController();

  final tipoController = TextEditingController();

  final lugarController = TextEditingController();

  final paisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tapa = ModalRoute.of(context)!.settings.arguments as Tapa;

    if (tapaAsStringBase64.isEmpty) {
      tapaAsStringBase64 = tapa.imagen;
    }

    nombreController.text = tapa.nombre;
    marcaController.text = tapa.marca;
    fechaController.text = tapa.fecha;
    colorController.text = tapa.color;
    lugarController.text = tapa.lugar;
    paisController.text = tapa.pais;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tapa"),
        actions: [
          IconButton(
            tooltip: "Favorito",
            icon: const Icon(Icons.favorite),
            onPressed: () {},
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: CreaTapa._formKey,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  //PhotoForm(),
                  Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
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
                            )),
                      ),
                    ),
                  ),

                  // Un textFormfield sirve para insertar textfields dentro de un form.
                  // Como se puede ver tiene un validador dentro
                  // TextFormField(
                  //   controller: nombreController,
                  //   textCapitalization: TextCapitalization.sentences,
                  //   decoration: InputDecoration(
                  //     border: UnderlineInputBorder(),
                  //     hintText: 'Nombre',
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                            controller: marcaController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Marca',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Debes insertar texto';
                              }
                              return null;
                            }),
                      ),
                      SizedBox(width: 100, child: TiposDeCervezaDropdown()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: InputDatePickerFormField(
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now()),
                      ),
                      TiposDeCervezaDropdown(),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: lugarController,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Lugar'),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                print('Hi');
                              },
                              child: Icon(Icons.near_me),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: colorController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Color de la tapa'),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: paisController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Pais de procedencia'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (CreaTapa._formKey.currentState!.validate()) {
                              if (tapa.id! > 0) {
                                tapa.imagen = tapaAsStringBase64;
                                tapa.marca = marcaController.text;
                                tapa.nombre = nombreController.text;
                                tapa.color = colorController.text;
                                tapa.fecha = DateTime.now().toString();
                                tapa.lugar = lugarController.text;
                                tapa.pais = paisController.text;
                                tapa.tipo = TiposDeCervezaDropdown().toString();
                                DB.update(tapa);
                              } else {
                                DB.insert(Tapa(
                                    imagen: tapaAsStringBase64,
                                    marca: marcaController.text,
                                    color: colorController.text,
                                    fecha: DateTime.now().toString(),
                                    lugar: lugarController.text,
                                    nombre: nombreController.text,
                                    pais: paisController.text,
                                    tipo: TiposDeCervezaDropdown().toString()));
                              }
                              Navigator.popAndPushNamed(context, "/");
                            }
                          },
                          child: const Text('Guardar')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/");
                          },
                          child: const Text('Cancelar'))
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
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

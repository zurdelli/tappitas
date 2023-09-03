import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:tappitas/screens/formTapa/widgets/dropdown_types.dart';
import 'package:tappitas/screens/formTapa/widgets/photo_form.dart';
import 'package:tappitas/screens/formTapa/select_photo_options_screen.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/utility.dart';

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
  File? imagen;
  String tapaAsStringBase64 = "";

  final nombreController = TextEditingController();

  final marcaController = TextEditingController();

  final fechaController = TextEditingController();

  final colorController = TextEditingController();

  final tipoController = TextEditingController();

  final lugarController = TextEditingController();

  final paisController = TextEditingController();

  // late String _tapaAsStringb64;
  @override
  Widget build(BuildContext context) {
    final tapa = ModalRoute.of(context)!.settings.arguments as Tapa;

    late String tapaAsStringb64;

    if (tapa.imagen.isNotEmpty) {
      tapaAsStringb64 = tapa.imagen;
      print("he llegado hasta aqui $tapaAsStringb64");
    } else {
      tapaAsStringb64 = "";
    }

    nombreController.text = tapa.nombre;
    marcaController.text = tapa.marca;
    fechaController.text = tapa.fecha;
    colorController.text = tapa.color;
    lugarController.text = tapa.lugar;
    paisController.text = tapa.pais;

    return Scaffold(
      appBar: AppBar(title: Text("Guardar")),
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
                              child: imagen == null
                                  ? const Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(imagen!),
                                      radius: 200.0,
                                    ),
                            )),
                      ),
                    ),
                  ),

                  // Un textFormfield sirve para insertar textfields dentro de un form.
                  // Como se puede ver tiene un validador dentro
                  TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Nombre',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Debes insertar texto';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: marcaController,
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
                  // DatePickerDialog(
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime(2000),
                  //     lastDate: DateTime.now()),
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
                    children: [DropdownButtonExample()],
                  ),

                  ElevatedButton(
                      onPressed: () {
                        print("tapaaaaaaaaaaaaaaaaaa: $tapaAsStringb64");
                        if (CreaTapa._formKey.currentState!.validate()) {
                          if (tapa.id! > 0) {
                            tapa.imagen = tapaAsStringb64;
                            tapa.marca = marcaController.text;
                            tapa.nombre = nombreController.text;
                            tapa.color = colorController.text;
                            tapa.fecha = DateTime.now().toString();
                            tapa.lugar = lugarController.text;
                            tapa.pais = paisController.text;
                            tapa.tipo = DropdownButtonExample().toString();
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
                                tipo: DropdownButtonExample().toString()));
                          }
                          Navigator.popAndPushNamed(context, "/");
                        }
                      },
                      child: const Text('Guardar')),
                ],
              )),
        ),
      ),
    );
  }

  // getPhoto(BuildContext context) async {
  // Future<String> pickImageFromGallery() async {
  //   String imagenAsStr = "";
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
  //   imagenAsStr = base64Encode(await imagen!.readAsBytes());

  //   return imagenAsStr;
  // }

  Future _pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      tapaAsStringBase64 = base64Encode(img.readAsBytesSync());
      print("tapaAsStringBase64: $tapaAsStringBase64");
      //img = await _cropImage(imageFile: img);

      setState(() {
        imagen = img;
        Navigator.of(context).pop();

        // Navigator.popAndPushNamed(context, "/formtapa",
        //     arguments: Tapa(
        //         id: 0,
        //         imagen: tapaAsStringBase64,
        //         nombre: '',
        //         color: '',
        //         fecha: DateFormat('dd:mm:yy').format(DateTime.now()).toString(),
        //         lugar: '',
        //         marca: '',
        //         pais: '',
        //         tipo: ''));
      });
    } on PlatformException catch (e) {
      print("exception: $e");
      Navigator.of(context).pop();
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

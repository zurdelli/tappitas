import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/screens/formTapa/select_photo_options_screen.dart';
import 'package:tappitas/utility.dart';
import 'package:tappitas/screens/formTapa/form_tapa.dart';
import 'package:tappitas/models/tapa.dart';

class PhotoForm extends StatefulWidget {
  PhotoForm({super.key});

  @override
  State<StatefulWidget> createState() => _PhotoFormState();
}

class _PhotoFormState extends State<PhotoForm> {
  File? imagen;
  String tapaAsStringBase64 = "";

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
        //Navigator.of(context).pop();

        Navigator.popAndPushNamed(context, "/formtapa",
            arguments: Tapa(
                id: 0,
                imagen: tapaAsStringBase64,
                nombre: '',
                color: '',
                fecha: DateFormat('dd:mm:yy').format(DateTime.now()).toString(),
                lugar: '',
                marca: '',
                pais: '',
                tipo: ''));
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

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }

  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }
}

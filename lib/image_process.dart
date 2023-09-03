import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// Procesador de imagen que muestra un alertdialog
class ImageProcess {
  late File _image, croppedFileFinal;
  CroppedFile? croppedFile;
  final picker = ImagePicker();

  //Getting Image From Gallery Or Camera.
  File getImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            content: Container(
                height: 250,
                width: 250,
                child: Row(
                  children: [
                    IconButton(
                        iconSize: 100,
                        icon: Icon(Icons.insert_photo),
                        onPressed: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 20);
                          _image = File(pickedFile!.path);
                          croppedFile = await _cropImage();
                          Navigator.of(context).pop(true);
                        }),
                    IconButton(
                        iconSize: 100,
                        icon: Icon(Icons.camera),
                        onPressed: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 20);
                          _image = File(pickedFile!.path);
                          croppedFile = await _cropImage();
                          Navigator.of(context).pop(true);
                        })
                  ],
                )),
          );
        });
    croppedFileFinal = File(croppedFile!.path);
    return croppedFileFinal;
  }

  // //Cropping image which has been retrieved from gallery
  // Future<CroppedFile?> _cropImage() async {

  //   final croppedFile await ImageCropper.cropImage(
  //     sourcePath: _image.path,
  //     compressFormat: ImageCompressFormat.jpg,
  //     compressQuality: 100,
  //   );
  // }

  Future<CroppedFile?> _cropImage() async {
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        return croppedFile;
      }
    }
  }
}

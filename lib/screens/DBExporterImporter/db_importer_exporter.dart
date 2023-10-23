import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tappitas/db.dart';
import 'package:sqflite_common_porter/sqflite_porter.dart';

class DBImporterExporter extends StatefulWidget {
  const DBImporterExporter({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DBImporterExporter> createState() => _DBImporterExporterState();
}

class _DBImporterExporterState extends State<DBImporterExporter> {
  String message = '';
  String nombreTabla = 'tapitas.db';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(message),
            ElevatedButton(
              onPressed: () async {
                String databasesPath = await getDatabasesPath();
                String dbPath = join(databasesPath, nombreTabla);

                Database myDB = await DB.getDB();

                File source1 = File(dbPath);
                //Database source1 = await openDatabase('$dbFolder/$nombreTabla');

                print('El objeto $source1 sera copiado');

                if (myDB.isOpen) {
                  print("Esta abierta");
                  DB.closeDB(myDB);
                  print("Esta cerrada");
                }

                Directory copyTo =
                    Directory("/storage/emulated/0/Documents/tappitas");
                if ((await copyTo.exists())) {
                  var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
                } else {
                  print("not exist");
                  if (await Permission.storage.request().isGranted) {
                    // Either the permission was already granted before or the user just granted it.
                    await copyTo.create(recursive: true);
                  } else {
                    print('Please give permission');
                  }
                }

                String newPath = "${copyTo.path}/$nombreTabla.backup";
                await source1.copy(newPath);

                setState(() {
                  message = 'Successfully Copied DB';
                });
              },
              child: const Text('Copy DB'),
            ),
            ElevatedButton(
              onPressed: () async {
                var databasesPath = await getDatabasesPath();
                var dbPath = join(databasesPath, nombreTabla);
                await deleteDatabase(dbPath);
                setState(() {
                  message = 'Successfully deleted DB';
                });
              },
              child: const Text('Delete DB'),
            ),
            ElevatedButton(
              onPressed: () async {
                var databasesPath = await getDatabasesPath();
                var dbPath = join(databasesPath, nombreTabla);

                var exists = await databaseExists(dbPath);
                print(exists ? "existe" : "no existe");

                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(withData: true);

                if (result != null) {
                  String resultPath = result.files.single.path!;
                  File source = File(resultPath);
                  // File source =
                  //     File(resultPath.substring(0, resultPath.length - 4));
                  //int lenght = source.size;
                  print("archivo de bkp: $source,\narchivo final: $dbPath");

                  await source.copy(dbPath);

                  setState(() {
                    message = 'Successfully Restored DB';
                  });
                } else {
                  // User canceled the picker
                }
              },
              child: const Text('Restore DB'),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<bool> _hasAcceptedPermissions() async {
// if (Platform.isAndroid) {
//   if (await _requestPermission(Permission.storage) &&
//       // access media location needed for android 10/Q
//       await _requestPermission(Permission.accessMediaLocation) &&
//       // manage external storage needed for android 11/R
      
//       await _requestPermission(Permission.manageExternalStorage)) {
//     return true;
//   } else {
//     return false;
//   }
// }
// if (Platform.isIOS) {
//   if (await _requestPermission(Permission.photos)) {
//     return true;
//   } else {
//     return false;
//   }
// } else {
//   // not android or ios
//   return false;
// }}



import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tappitas/models/tapa.dart';

/// Class to export or import a sqlite database
class DBImporterExporter extends StatefulWidget {
  const DBImporterExporter({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DBImporterExporter> createState() => _DBImporterExporterState();
}

class _DBImporterExporterState extends State<DBImporterExporter> {
  String message = '';

  String nombreTabla =
      'tapitas.db'; // must match with the table opened in db.dart

  String targetDir = "/storage/emulated/0/Documents/tappitas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 1.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            CustomButton(
              color: Color.fromARGB(135, 103, 120, 128),
              title: 'Export database',
              onPressed: () async {
                backupIsarDB();
              },
            ),
            CustomButton(
                color: Color.fromARGB(255, 101, 70, 68),
                title: 'Delete database',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context2) {
                      return AlertDialog(
                        title: Text("Delete"),
                        content: Text("Delete current database?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context2);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                var databasesPath = await getDatabasesPath();
                                var dbPath = join(databasesPath, nombreTabla);
                                await deleteDatabase(dbPath);
                                setState(() {
                                  message = 'Successfully deleted DB';
                                });
                                Navigator.pop(context2);
                              },
                              child: Text("Delete"))
                        ],
                      );
                    },
                  );
                }),
            CustomButton(
              color: const Color.fromARGB(255, 36, 82, 38),
              title: 'Import database',
              onPressed: () async {
                restoreIsarDB();
                // var databasesPath = await getDatabasesPath();
                // var dbPath = join(databasesPath, nombreTabla);

                // FilePickerResult? result =
                //     await FilePicker.platform.pickFiles(withData: true);

                // if (result != null) {
                //   String resultPath = result.files.single.path!;
                //   File source = File(resultPath);
                //   await source.copy(dbPath);

                //   setState(() {
                //     message = 'Successfully imported DB';
                //   });
                // }
              },
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  restoreIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File sourceFile = File(result.files.single.path!);

      await Isar.getInstance()!.close(deleteFromDisk: true).then((_) async {
        File targetFile = await sourceFile.copy("${dir.path}/default.isar");
        print("Correctly copied to ${targetFile.path}");
        await Isar.open(
          [TapaSchema],
          directory: dir.path,
        );
      });

      setState(() {
        message = 'Successfully imported DB';
      });
    }
  }

  backupIsarDB() async {
    final tapasInstance = Isar.getInstance();
    String targetFile =
        "$targetDir/${DateFormat('dd-MM-yyyy,H-m').format(DateTime.now()).toString()}.isar";

    tapasInstance!.copyToFile(targetFile);

    setState(() {
      message = 'Successfully Exported DB at: \n$targetFile';
    });
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.color,
      required this.title,
      required this.onPressed})
      : super(key: key);
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.tonal(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    //backgroundColor: color,
                    //foregroundColor: Colors.white,
                    padding: EdgeInsets.all(20),
                    textStyle: TextStyle(fontSize: 18)),
                //side: BorderSide(width: 2, color: Colors.white)),
                onPressed: () => onPressed(),
                child: Text(title)),
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

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
                String databasesPath = await getDatabasesPath();
                String dbPath = join(databasesPath, nombreTabla);
                File source1 = File(dbPath);
                Directory copyTo = Directory(targetDir);
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
                String today = DateFormat('dd-MM-yyyy,H-m-s')
                    .format(DateTime.now())
                    .toString();

                // Its needed to change the name for each backup - if not you won't be able to
                // restore the backup later
                String backupFile = "${copyTo.path}/$nombreTabla-$today.backup";

                await source1.copy(backupFile);

                setState(() {
                  message = 'Successfully Exported DB at: \n$backupFile';
                });
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
                var databasesPath = await getDatabasesPath();
                var dbPath = join(databasesPath, nombreTabla);

                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(withData: true);

                if (result != null) {
                  String resultPath = result.files.single.path!;
                  File source = File(resultPath);
                  await source.copy(dbPath);

                  setState(() {
                    message = 'Successfully imported DB';
                  });
                }
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

// Widget customButton(BuildContext context){

// }

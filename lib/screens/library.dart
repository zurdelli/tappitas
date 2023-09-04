import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/screens/home/widgets/bottom_app_bar.dart';

class Listado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tappitas"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.popAndPushNamed(context, "/formtapa",
                arguments: Tapa(
                    id: 0,
                    imagen: '',
                    nombre: '',
                    color: '',
                    fecha: DateFormat('dd:mm:yy')
                        .format(DateTime.now())
                        .toString(),
                    lugar: '',
                    marca: '',
                    pais: '',
                    tipo: ''));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: DemoBottomAppBar(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: const CircularNotchedRectangle(),
        ),
        body: //Column(
            //mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.center,
            //children: <Widget>[
            //Text('Este es el texto de prueba'),
            Lista()
        //],
        //),
        );
  }
}

class Lista extends StatefulWidget {
  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Tapa> tapitas = [];

  @override
  void initState() {
    cargaTapitas();
    super.initState();
  }

  cargaTapitas() async {
    List<Tapa> auxTapa = await DB.tapas();

    setState(() {
      tapitas = auxTapa;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tapitas.length,
      itemBuilder: (context, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(left: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white))),
        onDismissed: (direction) {
          DB.delete(tapitas[i]);
        },
        child: ListTile(
          title: Text.rich(
            TextSpan(
              text: "${tapitas[i].marca} - ",
              children: <TextSpan>[
                TextSpan(
                    text: tapitas[i].nombre,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "(${tapitas[i].pais})",
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: tapitas[i].imagen.isNotEmpty
                ? MemoryImage(base64Decode(tapitas[i].imagen))
                : null,
            radius: 30.0,
          ),
          subtitle: Text("Tomada el ${tapitas[i].fecha}"),
          isThreeLine: true,
          trailing: MaterialButton(
            onPressed: () {
              //se utiliza este metodo (popAndPushNamed) para terminar
              // con la pantalla y volver a abrir la otra por problemas
              // con el globalKey del form
              Navigator.popAndPushNamed(context, "/formtapa",
                  arguments: tapitas[i]);
            },
            child: Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}

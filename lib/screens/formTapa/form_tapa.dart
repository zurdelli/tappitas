import 'package:flutter/material.dart';
import 'package:tappitas/screens/formTapa/widgets/dropdown_types.dart';

import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';

//Clase que representa la pantalla con el formulario que se ve al querer crear
//una tapa
class CreaTapa extends StatelessWidget {
  CreaTapa({super.key});

  // Se debe crear una unica global key que identifica al form dentro de la app
  static final _formKey = GlobalKey<FormState>();

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
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset(
                      'assets/images/bud.jpg',
                      fit: BoxFit.cover,
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
                      if (_formKey.currentState!.validate()) {
                        if (tapa.id! > 0) {
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
            ),
          ),
        ),
      ),
    );
  }
}

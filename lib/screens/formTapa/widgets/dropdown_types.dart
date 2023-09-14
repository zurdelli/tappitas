import 'package:flutter/material.dart';
import 'package:tappitas/screens/formTapa/form_tapa.dart';

const List<String> listaTipos = <String>[
  'Rubia',
  'Tostada',
  'Roja',
  'Trigo',
  'Negra',
  'Gaseosa/Refresco',
  'Sin alcohol',
  'Otras'
];

class TiposDeCervezaDropdown extends StatefulWidget {
  TiposDeCervezaDropdown({super.key});

  @override
  State<TiposDeCervezaDropdown> createState() => TiposDeCervezaDropdownState();
}

class TiposDeCervezaDropdownState extends State<TiposDeCervezaDropdown> {
  String valor = listaTipos.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valor,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          valor = value!;
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
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';

class TypeModelRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TypeModelRowState();
}

class _TypeModelRowState extends State<TypeModelRow> {
  String type = "";
  String model = "";

  final modelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      type = context.read<TapaProvider>().type;
      model = context.read<TapaProvider>().model;

      modelController.text = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: dropDownBeerTypes(context, type),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            onTapOutside: (event) => context.read<TapaProvider>().model =
                modelController.text.trim(),
            controller: modelController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Model/Text'),
          ),
        ),
      ],
    );
  }

  Widget dropDownBeerTypes(BuildContext context, String valor) {
    if (valor.isEmpty) valor = "?";

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        //label: Text('Type'),
        //hintText: 'Marca',
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      value: valor,
      elevation: 16,
      //style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (String? value) {
        setState(() {
          valor = value!;
          context.read<TapaProvider>().type = value;
        });
      },
      items: typesOfBeer.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

const List<String> typesOfBeer = <String>[
  '?',
  'Lager',
  'Ale',
  'Amber (Doubel, Tripel)',
  'Weiss',
  'IPA/APA',
  'Stout',
  'Red',
  'Alcohol Free',
  'Soft Drink',
  'Water',
  'Cider',
  'Alcopop',
  'Other'
];

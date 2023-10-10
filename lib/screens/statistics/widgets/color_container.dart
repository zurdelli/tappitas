import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tappitas/db.dart';

class ColorContainer extends StatefulWidget {
  const ColorContainer({super.key});

  @override
  State<ColorContainer> createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  bool selected = false;
  bool isFinished = false;
  Future<List<Map<String, Object?>>>? listaColores;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
            listaColores = DB.gimmeSomeData("primColor");
          });
        },
        child: Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                  width: 400,
                  height: selected ? 200 : 50,
                  color: Color.fromARGB(0, 255, 255, 255),
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(style: TextStyle(fontSize: 24), "Por color"),
                          selected
                              ? Icon(Icons.keyboard_arrow_up)
                              : Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      if (listaColores != null && selected)
                        FutureBuilder(
                            future: listaColores,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && selected) {
                                List lista = snapshot.data ?? List.empty();
                                //Map result = {};
                                //List lista2 = [];
                                StringBuffer myString = StringBuffer();
                                for (var element in lista) {
                                    // element es un mapa
                                    myString.write("\n");
                                    //element.forEach((k, v) => lista2.add(v));
                                    element.forEach((k, v) {
                                      v.toString().isEmpty
                                          ? myString.write("undefined ")
                                          : myString.write("$v ");
                                    });
                                  }

                                return Text(
                                    style: TextStyle(fontSize: 20),
                                    '$myString');
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error: ${snapshot.error.toString()}');
                              } else {
                                return Text("");
                              }
                            }),
                    ],
                  )),
            ),
          ],
        ));
  }
}

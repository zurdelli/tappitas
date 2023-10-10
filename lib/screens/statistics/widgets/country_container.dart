import 'package:flutter/material.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/screens/statistics/widgets/expanded_section.dart';

class CountryContainer extends StatefulWidget {
  const CountryContainer({super.key});

  @override
  State<CountryContainer> createState() => _CountryContainerState();
}

class _CountryContainerState extends State<CountryContainer> {
  bool selected = false;
  Future<List<Map<String, Object?>>>? listCountries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
            listCountries = DB.gimmeSomeData("brewCountry");
          });
        },
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Por pais"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                listCountries == null
                    ? const Text("Cliqueame")
                    : FutureBuilder(
                        future: listCountries,
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
                                  myString.write("$v ");
                                });
                              }

                            return ExpandedSection(child: Text('$myString'));
                          } else if (snapshot.hasError) {
                            return Text(
                                'Delivery error: ${snapshot.error.toString()}');
                          } else {
                            return Text("");
                          }
                        }),
              ],
            ),
          ),
        ]));
  }
}

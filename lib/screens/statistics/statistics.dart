import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/models/tapa.dart';
import 'package:tappitas/provider/order_provider.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics",
            style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Total: ${context.read<OrderProvider>().cantTappas}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              //child: Container(),
              child: FutureBuilder<List<Step>>(
                  future: getStatistics(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Step>> snapshot) {
                    if (snapshot.hasData) {
                      return EPStatistics(steps: snapshot.data ?? []);
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: LinearProgressIndicator(),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/// retorna una ExpansionPanelList
class EPStatistics extends StatefulWidget {
  final List<Step> steps;
  const EPStatistics({Key? key, required this.steps}) : super(key: key);

  @override
  State<EPStatistics> createState() => _EPStatisticsState(steps: steps);
}

class _EPStatisticsState extends State<EPStatistics> {
  _EPStatisticsState({required List<Step> steps}) : _steps = steps;

  final List<Step> _steps;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      elevation: 1,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !_steps[index].isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
              titleTextStyle: TextStyle(
                  fontSize: 24,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white),
            );
          },
          body: ListTile(
            title: Text(
              step.body,
              style: TextStyle(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

Future<List<Step>> getStatistics() async {
  var items = [
    Step('By Color', await listOfSomething("primColor")),
    Step('By Country', await listOfSomething("brewCountry")),
    Step('By Brewery', await listOfSomething("brewery")),
    Step('By Date', await listOfSomething("date")),
    Step('By Place', await listOfSomething("place")),
  ];
  return items;
}

Future<String> listOfSomething(String clausule) async {
  final isar = Isar.getInstance();
  //List<Tapa> tapasAux = await isar!.tapas.where().findAll();

  final lista;
  Map<String, int> mapaColores = {};

  switch (clausule) {
    case "primColor":
      lista = await isar!.tapas
          .where()
          .distinctByPrimColor()
          .primColorProperty()
          .findAll();

      for (final color in lista) {
        mapaColores[color!] =
            await isar.tapas.filter().primColorEqualTo(color).count();
      }
      print(lista);
      break;
    case "brewCountry":
      lista = await isar!.tapas
          .where()
          .sortByBrewCountryDesc()
          .distinctByBrewCountry()
          .brewCountryProperty()
          .findAll();

      for (final color in lista) {
        mapaColores[color!] =
            await isar.tapas.filter().brewCountryEqualTo(color).count();
      }
      break;
    case "brewery":
      lista = await isar!.tapas
          .where()
          .sortByBreweryDesc()
          .distinctByBrewery()
          .breweryProperty()
          .findAll();

      for (final color in lista) {
        mapaColores[color!] =
            await isar.tapas.filter().breweryEqualTo(color).count();
      }
      break;
    case "date":
      lista = await isar!.tapas
          .where()
          .sortByDateDesc()
          .distinctByDate()
          .dateProperty()
          .findAll();

      for (final color in lista) {
        mapaColores[color!] =
            await isar.tapas.filter().dateEqualTo(color).count();
      }
      break;
    case "place":
      lista = await isar!.tapas
          .where()
          .sortByPlaceDesc()
          .distinctByPlace()
          .placeProperty()
          .findAll();

      for (final color in lista) {
        mapaColores[color!] =
            await isar.tapas.filter().placeEqualTo(color).count();
      }
      break;
  }

  //print(mapaColores.toString());

  StringBuffer myString = StringBuffer();

  var sortedByValueList = mapaColores.entries.toList()
    ..sort((e1, e2) => e1.value.compareTo(e2.value));

  final sortedByValueMap = Map.fromEntries(sortedByValueList.reversed);
  //print(sortedByValueMap.entries.toList().reversed);

  for (var element in sortedByValueMap.entries) {
    myString.write(element.value);
    myString.write(' ');
    myString.write(element.key.isEmpty ? "undefined" : element.key);
    myString.write('\n');
  }

  //print(myString);
  return myString.toString();
}

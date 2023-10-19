import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/db.dart';
import 'package:tappitas/provider/order_provider.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

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
              "Total: ${Provider.of<OrderProvider>(context).cantTappas}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              child: FutureBuilder<List<Step>>(
                  future: getSteps(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Step>> snapshot) {
                    if (snapshot.hasData) {
                      return Statistics(steps: snapshot.data ?? []);
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

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

Future<List<Step>> getSteps() async {
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
  List lista = await DB.gimmeSomeData(clausule);

  StringBuffer myString = StringBuffer();

  for (var element in lista) {
    myString.write('\n');
    element.forEach((k, v) {
      v.toString().isEmpty
          ? myString.write("undefined ")
          : myString.write("$v ");
    });
  }

  return myString.toString();
}

class Statistics extends StatefulWidget {
  final List<Step> steps;
  const Statistics({Key? key, required this.steps}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState(steps: steps);
}

class _StatisticsState extends State<Statistics> {
  _StatisticsState({required List<Step> steps}) : _steps = steps;

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
              titleTextStyle: TextStyle(fontSize: 24),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}

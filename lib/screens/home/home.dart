import 'package:flutter/material.dart';
import 'package:tappitas/screens/home/widgets/app_bar.dart';
import 'package:tappitas/screens/library.dart';

import '../formTapa/form_tapa.dart';

// Las statefulWidget se manejan x si solas, se usan cuando otras clases no necesitan
// pedir datos a ellas
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tappitas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MiHome(),
    );
  }
}

class MiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", routes: {
      "/": (context) => Listado(),
      "/formtapa": (context) => CreaTapa()
    });
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   var selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     Widget pagina = MenuPrincipal();

//     switch (selectedIndex) {
//       case 0:
//         pagina = MenuPrincipal();
//         break;
//       case 1:
//         pagina = CreaTapa();
//         break;
//       default:
//         print('Error');
//     }

//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Container(
//         child: pagina,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             selectedIndex = 1;
//           });
//         },
//         tooltip: 'Create',
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // Se enlaza al widget del bottom app bar
//       bottomNavigationBar: DemoBottomAppBar(
//         fabLocation: FloatingActionButtonLocation.centerDocked,
//         shape: const CircularNotchedRectangle(),
//       ),
//     );
//   }
// }

// class MenuPrincipal extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MenuPrincipalState();
//   }
// }

// class _MenuPrincipalState extends State<MenuPrincipal> {
//   bool _showNotch = true;
//   bool _showFab = true;

//   FloatingActionButtonLocation fabLocation =
//       FloatingActionButtonLocation.endDocked;

//   // Toggles
//   void _onShowNotchChanged(bool value) {
//     setState(() {
//       _showNotch = false;
//     });
//   }

//   void _onShowFabChanged(bool value) {
//     setState(() {
//       _showFab = value;
//     });
//   }

//   // Los ?? creo que eran por si value es nulo
//   void _onFabLocationChanged(FloatingActionButtonLocation? value) {
//     setState(() {
//       fabLocation = value ?? FloatingActionButtonLocation.endDocked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.only(bottom: 88),
//       children: <Widget>[
//         SwitchListTile(
//           title: const Text('Boton de accion flotante'),
//           value: _showFab,
//           onChanged: _onShowFabChanged,
//         ),
//         SwitchListTile(
//           title: const Text('Notch'),
//           value: _showNotch,
//           onChanged: _onShowNotchChanged,
//         ),
//         const Padding(
//           padding: EdgeInsets.all(16),
//           child: Text('Floating action button position'),
//         ),
//         RadioListTile<FloatingActionButtonLocation>(
//           title: const Text('Docked - End'),
//           value: FloatingActionButtonLocation.endDocked,
//           groupValue: fabLocation,
//           onChanged: _onFabLocationChanged,
//         ),
//         RadioListTile<FloatingActionButtonLocation>(
//           title: const Text('Docked - Center'),
//           value: FloatingActionButtonLocation.centerDocked,
//           groupValue: fabLocation,
//           onChanged: _onFabLocationChanged,
//         ),
//         RadioListTile<FloatingActionButtonLocation>(
//           title: const Text('Floating - End'),
//           value: FloatingActionButtonLocation.endFloat,
//           groupValue: fabLocation,
//           onChanged: _onFabLocationChanged,
//         ),
//         RadioListTile<FloatingActionButtonLocation>(
//           title: const Text('Floating - Center'),
//           value: FloatingActionButtonLocation.centerFloat,
//           groupValue: fabLocation,
//           onChanged: _onFabLocationChanged,
//         ),
//       ],
//     );
//   }
// }

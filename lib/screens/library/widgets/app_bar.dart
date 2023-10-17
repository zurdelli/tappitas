import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/screens/library/widgets/order_types.dart';
import 'package:tappitas/utilities.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {required this.titulo, required this.cantidad, required this.callback});
  final String titulo;
  final int cantidad;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Text(titulo, style: GoogleFonts.leckerliOne(), textScaleFactor: 1.2),
      actions: <Widget>[
        IconButton(
            onPressed: () =>
                muestraAlertDialog(context, null, dialog: 'busqueda'),
            icon: const Icon(Icons.search),
            tooltip: 'Buscar'),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, "/statistics", arguments: cantidad),
          icon: Icon(Icons.filter_list),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 0.5,
                minChildSize: 0.28,
                expand: false,
                builder: ((context, scrollController) {
                  return OrderTypesOptions();
                }),
              ),
            ).then(
                (value) => callback(context.read<OrderProvider>().orderString));
          },
          icon: Icon(Icons.sort_by_alpha_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Platform.isAndroid ? Icons.more_vert : Icons.more_horiz),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

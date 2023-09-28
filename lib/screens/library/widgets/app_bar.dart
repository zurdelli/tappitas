import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tappitas/utilities.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({required this.titulo});
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      actions: <Widget>[
        IconButton(
            onPressed: () => Utilities().muestraAlertDialog(context, 0, null),
            icon: const Icon(Icons.search),
            tooltip: 'Buscar'),
        IconButton(
          onPressed: () => Navigator.pushNamed(
            context,
            "/statistics",
          ),
          icon: Icon(Icons.filter_list),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.book),
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

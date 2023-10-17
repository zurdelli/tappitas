import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/screens/library/widgets/order_types.dart';
import 'package:tappitas/screens/search/dialog_search.dart';
//import 'package:tappitas/utilities.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({required this.titulo, required this.callback});
  final String titulo;
  final Function callback;

  //var isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Text(titulo, style: GoogleFonts.leckerliOne(), textScaleFactor: 1.1),
      actions: <Widget>[
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
                  initialChildSize: 0.7,
                  maxChildSize: 0.8,
                  minChildSize: 0.28,
                  expand: false,
                  builder: ((context, scrollController) {
                    return DialogSearch();
                  }),
                ),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search'),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, "/statistics"),
          icon: Icon(Icons.bar_chart),
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
        MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: Text("Settings"),
                onPressed: () {},
              ),
              MenuItemButton(
                child: Text("Dark Mode"),
                onPressed: () {},
              ),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return TextButton(
                //focusNode: _buttonFocusNode,
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: const Icon(Icons.more_vert),
              );
            })
      ],
    );
  }

  void changeDarkMode(bool newValue) {}

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

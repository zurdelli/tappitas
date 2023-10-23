import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';
import 'package:tappitas/screens/library/widgets/order_types.dart';
import 'package:tappitas/screens/search/widgets/dialog_search.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({required this.titulo, required this.callback});
  final String titulo;
  final Function callback;

  //var isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo,
          style: TextStyle(fontFamily: 'Aladin'), textScaleFactor: 1.4),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              showDialog(
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AlertDialog(
                    //shape: CircleBorder(),
                    content: DialogSearch(),
                  ),
                ),
                context: context,
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
                child: Text("Import/Export Database"),
                onPressed: () => Navigator.pushNamed(context, '/dbie').then(
                    (value) =>
                        callback(context.read<OrderProvider>().orderString)),
              ),
              MenuItemButton(
                child: Text("About"),
                onPressed: () {
                  Navigator.pushNamed(context, "/about");
                },
              ),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return TextButton(
                //focusNode: _buttonFocusNode,
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                child: const Icon(Icons.more_vert),
              );
            })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/utilities.dart';

class ColorsRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ColorsRowState();
}

class _ColorsRowState extends State<ColorsRow> {
  Color _color1 = Colors.transparent;
  Color _color2 = Colors.transparent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _color1 = context.read<TapaProvider>().color1;
      _color2 = context.read<TapaProvider>().color2;
    });
  }

  void setColor1(Color newColor) => setState(() {
        _color1 = newColor;
        context.read<TapaProvider>().color1 = _color1;
      });
  void setColor2(Color newColor) => setState(() {
        _color2 = newColor;
        context.read<TapaProvider>().color2 = _color2;
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                //minimumSize: Size(160, 60),
                shape: ContinuousRectangleBorder(),
                side: BorderSide(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    width: 0.5),
                backgroundColor: _color1,
                foregroundColor: _color1 == Colors.white ||
                        MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                    ? Colors.black
                    : Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Pick a color"),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: _color1,
                        onColorChanged: (value) => setColor1(value),
                        availableColors: colors,
                        layoutBuilder: pickerLayoutBuilder,
                        itemBuilder: pickerItemBuilder,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.color_lens)),
                  TextSpan(
                      text: colorToString(_color1).isEmpty
                          ? '1st color'
                          : colorToString(_color1))
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                //minimumSize: Size(160, 60),
                shape: ContinuousRectangleBorder(),
                side: BorderSide(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    width: 0.5),
                backgroundColor: _color2,
                foregroundColor: _color2 == Colors.white ||
                        MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                    ? Colors.black
                    : Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: _color2,
                        onColorChanged: (value) => setColor2(value),
                        availableColors: colors,
                        layoutBuilder: pickerLayoutBuilder,
                        itemBuilder: pickerItemBuilder,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.color_lens)),
                  TextSpan(
                      text: colorToString(_color2).isEmpty
                          ? '2nd color'
                          : colorToString(_color2))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
      _color1 = Provider.of<TapaProvider>(context, listen: false).color1;
      _color2 = Provider.of<TapaProvider>(context, listen: false).color2;
    });
  }

  void setColor1(Color newColor) => setState(() {
        _color1 = newColor;
        Provider.of<TapaProvider>(context, listen: false).color1 = _color1;
      });
  void setColor2(Color newColor) => setState(() {
        _color2 = newColor;
        Provider.of<TapaProvider>(context, listen: false).color2 = _color2;
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
                    title: const Text('Select a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: _color1,
                        onColorChanged: (value) => setColor1(value),
                        availableColors: colors,
                        layoutBuilder: pickerLayoutBuilder,
                        itemBuilder: pickerItemBuilder,
                      ),
                    ),
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
                    title: const Text('Select a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: _color2,
                        onColorChanged: (value) => setColor2(value),
                        availableColors: colors,
                        layoutBuilder: pickerLayoutBuilder,
                        itemBuilder: pickerItemBuilder,
                      ),
                    ),
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

Widget pickerLayoutBuilder(
    BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 300,
    height: orientation == Orientation.portrait ? 360 : 240,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}

Widget pickerItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: color,
      boxShadow: [
        BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1, 2),
            blurRadius: 5)
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: 24,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}

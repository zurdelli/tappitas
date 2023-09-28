import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/slider_provider.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  //double lastRating = 0.0;

  @override
  Widget build(BuildContext context) {
    // Obtengo el objeto sliderRating con Provider.of
    final sliderRating = Provider.of<SliderProvider>(context);
    return SizedBox(
      width: 300,
      child: Slider.adaptive(
        value: sliderRating.value,
        onChanged: (newRating) =>
            setState(() => sliderRating.value = newRating),
        min: 0,
        max: 5,
        divisions: 10,
        label: "${sliderRating.value}",
        activeColor: Colors.amber,
        secondaryActiveColor: Colors.white,
      ),
    );
  }
}

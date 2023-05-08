import 'package:flutter/material.dart';
import 'package:tappitas/constants.dart';

AppBar buildAppBar() => AppBar(
      backgroundColor: Colors.red,
      elevation: 0,
      centerTitle: false,
      title: Text('Tappitas'),
      actions: [Padding(padding: const EdgeInsets.all(Constants.kPadding))],
    );

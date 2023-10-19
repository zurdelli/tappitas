import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Tappitas",
                  style: TextStyle(
                      fontFamily: 'Aladin',
                      decoration: TextDecoration.underline),
                  textScaleFactor: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text:
                        'Tappitas is an Android app to manage a collection of beer'
                        ' caps (or whatever drink who use a cap). The name comes'
                        ' from Latin American Spanish, where a cap is called tapita. '
                        ' The idea to make this project comes from my desire of manage',
                    style: TextStyle(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        height: 1.7),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' my collection of caps',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse(
                                  "https://www.instagram.com/p/Cv7x6cFrzBr/?img_index=1"));
                            }),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 100,
                ),
                Text(
                  "Created by Zurdelli",
                  style: TextStyle(fontFamily: 'Aladin'),
                  textScaleFactor: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: Image.asset(
                        'assets/images/andy.jpg',
                      ).image,
                    ),
                    onTap: () =>
                        launchUrl(Uri.parse("https://zurdelli.github.io/"))),
              ],
            ),
          )),
    );
  }
}

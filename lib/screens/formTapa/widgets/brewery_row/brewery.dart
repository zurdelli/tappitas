import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget breweryRow(
    TextEditingController breweryController,
    TextEditingController brewCountryController,
    BuildContext context,
    String selectedCountry,
    String selectedCountryCode) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    TextField(
      controller: breweryController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
        focusColor: Colors.black,
      ),
    ),
    SizedBox(
      height: 10,
    ),
    TextField(
        controller: brewCountryController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
            labelText: "Country",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                _launchUrl(breweryController.text, context);
              },
            )),
        readOnly: true,
        onTap: () => showCountryPicker(
            context: context,
            onSelect: (Country country) {
              brewCountryController.text =
                  "${country.name} ${countryCodeToEmoji(country.countryCode)}";
            },
            favorite: <String>['ES', 'DE', 'BE'])),
  ]);
}

Future<void> _launchUrl(String brewery, BuildContext context) async {
  if (brewery.isNotEmpty) {
    final url = Uri.encodeFull(
        "https://google.com/search?q=where+is+$brewery+beer+made");
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You must provide brewery name"),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
    ));
  }
}

String countryCodeToEmoji(String countryCode) {
  // 0x41 is Letter A
  // 0x1F1E6 is Regional Indicator Symbol Letter A
  // Example :
  // firstLetter U => 20 + 0x1F1E6
  // secondLetter S => 18 + 0x1F1E6
  // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}

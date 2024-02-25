import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';
import 'package:tappitas/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class BreweryRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BreweryRowState();
}

class _BreweryRowState extends State<BreweryRow> {
  String brewery = "";
  String breweryCountry = "";
  String breweryCountryCode = "";

  final breweryController = TextEditingController();
  final brewCountryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      brewery = breweryController.text = context.read<TapaProvider>().brewery;
      breweryCountry = brewCountryController.text = context.read<TapaProvider>().brewCountry;
      breweryCountryCode = context.read<TapaProvider>().brewCountryCode;
      //breweryController.text = brewery;
      //brewCountryController.text = breweryCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return breweryWidget(breweryController, brewCountryController, context,
        breweryCountry, breweryCountryCode);
  }
}

Widget breweryWidget(
    TextEditingController breweryController,
    TextEditingController brewCountryController,
    BuildContext context,
    String selectedCountry,
    String selectedCountryCode) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    TextField(
      controller: breweryController,
      onTapOutside: (_) => Provider.of<TapaProvider>(context, listen: false)
          .brewery = breweryController.text.trim(),
      textCapitalization: TextCapitalization.words,
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
              Provider.of<TapaProvider>(context, listen: false).brewCountry =
                  country.name;
              Provider.of<TapaProvider>(context, listen: false)
                  .brewCountryCode = country.countryCode;

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

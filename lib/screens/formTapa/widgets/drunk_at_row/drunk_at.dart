import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding_package;
import 'package:intl/intl.dart';
import 'package:location/location.dart' as location_package;
import 'package:provider/provider.dart';
import 'package:tappitas/provider/tapa_provider.dart';

class DrinkedAtRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrinkedAtRowState();
}

class _DrinkedAtRowState extends State<DrinkedAtRow> {
  String date = "";
  String place = "";

  final placeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      date = context.read<TapaProvider>().date;
      place = context.read<TapaProvider>().place;

      placeController.text = place;
      dateController.text = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // Drinked @ row
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.parse(context.read<TapaProvider>().date),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateController.text = formattedDate;
                      Provider.of<TapaProvider>(context, listen: false).date =
                          formattedDate;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: placeController,
                onTapOutside: (event) =>
                    Provider.of<TapaProvider>(context, listen: false).place =
                        placeController.text.trim(),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.near_me),
                  suffixIcon: IconButton(
                    color: Colors.blue,
                    //alignment: Alignment.centerRight,
                    icon: Icon(Icons.gps_fixed),
                    onPressed: () {
                      getLocation();
                    },
                  ),
                  labelText: 'Place',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getLocation() async {
    location_package.Location location = location_package.Location();

    bool serviceEnabled;
    location_package.PermissionStatus permissionGranted;
    location_package.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == location_package.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != location_package.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    //print("La latitud es: ${locationData.latitude}");
    double latitud = locationData.latitude ?? 0;
    double longitud = locationData.longitude ?? 0;

    List<geocoding_package.Placemark> placemarks =
        await geocoding_package.placemarkFromCoordinates(latitud, longitud);

    String place = "${placemarks[0].locality}, ${placemarks[0].country}";

    placeController.text = place;
    Provider.of<TapaProvider>(context, listen: false).place = place;
    //return place;
  }
}

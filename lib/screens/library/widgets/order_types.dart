import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';

enum OrderTypes { id, brewery, brewCountry, date, primColor, place }

class OrderTypesOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderTypesOptionsState();
}

class _OrderTypesOptionsState extends State<OrderTypesOptions> {
  OrderTypes? _orderType = OrderTypes.brewery;
  late String lastTypeOrder = "brewery";

  @override
  Widget build(BuildContext context) {
    lastTypeOrder = Provider.of<OrderProvider>(context).orderString;
    _orderType = OrderTypes.values
        .firstWhere((e) => e.toString() == 'OrderTypes.$lastTypeOrder');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text("Order by", style: GoogleFonts.aladin(), textScaleFactor: 2),
          ListTile(
            title: const Text('Name'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.brewery,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Country'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.brewCountry,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Date'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.date,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Color'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.primColor,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Place'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.place,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Last Modified'),
            leading: Radio<OrderTypes>(
              value: OrderTypes.id,
              groupValue: _orderType,
              onChanged: (OrderTypes? value) {
                setState(() {
                  _orderType = value;
                  context.read<OrderProvider>().orderString =
                      _orderType.toString().split('.').last;
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}

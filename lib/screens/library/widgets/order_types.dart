import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tappitas/provider/order_provider.dart';

enum OrderTypes { brewery, brewCountry, date, primColor, place }

class OrderTypesOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderTypesOptionsState();
}

class _OrderTypesOptionsState extends State<OrderTypesOptions> {
  OrderTypes? _orderType;
  late String lastTypeOrder;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      lastTypeOrder =
          Provider.of<OrderProvider>(context, listen: false).orderString;
      print(lastTypeOrder);
      _orderType = OrderTypes.values
          .firstWhere((e) => e.toString() == 'OrderTypes.$lastTypeOrder');
      print(_orderType.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // lastTypeOrder = Provider.of<OrderProvider>(context).orderString;
    // _orderType = OrderTypes.values
    //     .firstWhere((e) => e.toString() == 'OrderTypes.$lastTypeOrder');

    return SingleChildScrollView(
      child: Column(children: [
        ListTile(
          title: const Text('Name'),
          leading: Radio<OrderTypes>(
            value: OrderTypes.brewery,
            groupValue: _orderType,
            onChanged: (OrderTypes? value) {
              setState(() {
                _orderType = value;
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
              });
            },
          ),
        ),
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              context.read<OrderProvider>().orderString =
                  _orderType.toString().split('.').last;
              print(context.read<OrderProvider>().orderString);

              Navigator.pop(context);
            }),
      ]),
    );
  }
}

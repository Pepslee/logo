import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String itemName;
  const Item({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      // margin: const EdgeInsets.all(15.0),
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2)
      ),
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(itemName)),
    );
  }
}

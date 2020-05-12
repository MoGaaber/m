import 'package:flutter/material.dart';

class MySearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Flights',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

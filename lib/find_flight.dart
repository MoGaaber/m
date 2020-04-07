import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen.dart';

class FindFlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    print(screen.width.toString() + '!!');
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.person_pin_circle),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text('Adults'), Text('16+ years')],
              ),
              Spacer(
                flex: 12,
              ),
              MyButton(),
              Spacer(),
              Text('1'),
              Spacer(),
              MyButton()
            ],
          )
        ],
      ),
    ));
  }
}

class MyButton extends StatelessWidget {
  Color color;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

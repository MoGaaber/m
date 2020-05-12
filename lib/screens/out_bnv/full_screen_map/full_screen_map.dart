import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m/commons/widgets/map.dart';

class FullScreenMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LatLng latLng = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: MyMap(latLng),
    );
  }
}

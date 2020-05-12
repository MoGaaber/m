import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatelessWidget {
  static const route = '/map';
  final LatLng latLng;
  MyMap(this.latLng);
  @override
  Widget build(BuildContext context) {
    return GoogleMap(markers: {
      Marker(markerId: MarkerId('id'), position: latLng),
    }, initialCameraPosition: CameraPosition(target: latLng, zoom: 6));
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final double lat, long;
  const MapView({Key key, this.lat, this.long}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set.of([
        Marker(markerId: MarkerId('aa'), position: LatLng(this.lat, this.long))
      ]),
      initialCameraPosition:
          CameraPosition(target: LatLng(this.lat, this.long), zoom: 10),
    );
  }
}

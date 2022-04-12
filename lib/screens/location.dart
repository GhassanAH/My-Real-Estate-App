import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/poster.dart';

class location extends StatefulWidget {
  PosterInfo post;

  location({Key? key, required this.post}) : super(key: key);
  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {

    List<Marker> markers = [
    Marker(
      
      markerId: MarkerId('marker1'),
    ),
  ];

  Future<Set<Marker>> addMarker(Position newMarkerPosition) async {

    markers.add(
      Marker(
        onTap: () {
          print('Tapped');
        },
        
        markerId: MarkerId('marker1'),
        position:
            LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),
      ),
    );
    return markers.toSet();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post Location"),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height -100,
                padding: EdgeInsets.all(20.2),
                child: FutureBuilder(
                    future: addMarker(Position(
                      latitude: widget.post.lat,
                      longitude: widget.post.long,
                      accuracy: 1,
                      altitude: 1,
                      heading: 1,
                      speed: 1,
                      speedAccuracy: 1,
                      timestamp: null,
                    )),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(23.5880, 58.3829), zoom: 13.5),
                          markers: snapshot.data);
                    }))));
  }
}

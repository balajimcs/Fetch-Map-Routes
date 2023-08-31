import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show sin, cos, sqrt, atan2;

import 'package:maps_routes_app/resources/app_colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController googleMapController;
  LatLng startPoint = LatLng(11.0168, 76.9558);
  LatLng endPoint = LatLng(9.9252, 78.1198);
  // static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  double calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371.0; 
    double lat1 = start.latitude;
    double lon1 = start.longitude;
    double lat2 = end.latitude;
    double lon2 = end.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

// Convert degrees to radians
  double _toRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }

  String calculateDuration(
      double distanceInKilometers, double speedInKmPerHour) {
    double timeInHours = distanceInKilometers / speedInKmPerHour;
    int hours = timeInHours.floor();
    int minutes = ((timeInHours - hours) * 60).ceil();

    if (hours == 0) {
      return '$minutes mins';
    } else {
      return '$hours hrs $minutes mins';
    }
  }

  String distanceText = '';
  String durationText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(
              Icons.keyboard_backspace_outlined,
              color: AppColors.white,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF134FAF), Color(0xFF134FAF)]),
            ),
          ),
          // backgroundColor: AppColors.primaryColor,
          elevation: 0,
          title: Text(
            "Google Map",
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: 'Raleway'),
          ),
        ),
      body: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Icon(
                Icons.map, 
                size: 48.0,
                color: Theme.of(context)
                    .primaryColor, 
              ),
            ); 
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); 
          } else if (snapshot.hasData) {
            Position position = snapshot.data!;

            CameraPosition initialCameraPosition = CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14);

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  markers: markers,
                  polylines: polylines,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                ),
                Positioned(
                  top: 630,
                  left: 10,
                  child: Card(
                    elevation: 50,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                      width: 230,
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              distanceText,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  color: Colors.black),
                            ),
                            SizedBox(height: 10,), 
                            Text(
                              durationText,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
                child:
                    Text('Unknown error occurred.')); 
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 5)));

          markers.clear();
          polylines.clear();

          markers.add(Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(position.latitude, position.longitude)));
          markers.add(Marker(
              markerId: const MarkerId('startPoint'),
              position: startPoint)); // Add start point marker
          markers.add(Marker(
              markerId: const MarkerId('endPoint'),
              position: endPoint)); // Add end point marker

          Polyline routePolyline = Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: [startPoint, endPoint],
          );

          polylines.add(routePolyline);

          double distance = calculateDistance(startPoint, endPoint);
          String duration = calculateDuration(
              distance, 30.0); // Assuming bus speed of 30 km/h

          setState(() {
            distanceText = 'Distance: ${distance.toStringAsFixed(2)} km';
            durationText = 'Duration: $duration';
          });
        },
        label: const Text("Routes"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}

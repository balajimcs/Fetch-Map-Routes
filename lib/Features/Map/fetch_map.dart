import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_routes_app/controller/mapController.dart';
import 'package:maps_routes_app/resources/app_colors.dart';

class FetchMap extends StatefulWidget {
  const FetchMap({Key? key}) : super(key: key);

  @override
  _FetchMapState createState() => _FetchMapState();
}

class _FetchMapState extends State<FetchMap> {
  final mapController = Get.put(MapController());

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
            "Fetch Google Map",
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: 'Raleway'),
          ),
        ),
      body: Obx(
        () => GoogleMap(
          onMapCreated: (controller) {
            mapController.mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 10,
          ),
          markers: mapController.userData.map((user) {
            final lat = double.parse(user['address']['geo']['lat']);
            final lng = double.parse(user['address']['geo']['lng']);
            final userLatLng = LatLng(lat, lng);

            String generateInfoSnippet(Map<String, dynamic> user) {
              String street = user['address']['street'];
              String suite = user['address']['suite'];
              String city = user['address']['city'];
              String zipcode = user['address']['zipcode'];

              String address = '$street, $suite, $city, $zipcode';
              int maxSnippetLength = 100;

              if (address.length > maxSnippetLength) {
                address = address.substring(0, maxSnippetLength - 3) + '...';
              }

              String snippet =
                  'Username: ${user['username']}\nEmail: ${user['email']}\nAddress: $address';
              return snippet;
            }

            return Marker(
              markerId: MarkerId(user['id'].toString()),
              position: userLatLng,
              onTap: () =>
                  mapController.onMarkerTapped(MarkerId(user['id'].toString())),
              infoWindow: InfoWindow(
                title: user['name'],
                snippet: generateInfoSnippet(user),
              ),
            );
          }).toSet(),
        ),
      ),
    );
  }
}

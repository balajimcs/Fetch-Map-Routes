import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maps_routes_app/controller/base_controller.dart';

class MapController extends BaseController {
  late GoogleMapController mapController;
  RxList<dynamic> userData = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      userData.assignAll(json.decode(response.body));
    }
  }

  void onMarkerTapped(MarkerId markerId) {
    final user = userData.firstWhere((user) => user['id'].toString() == markerId.value);

    // Extract user details
    final address = user['address'];

    final lat = double.parse(address['geo']['lat']);
    final lng = double.parse(address['geo']['lng']);
    final userLatLng = LatLng(lat, lng);

    mapController.animateCamera(
      CameraUpdate.newLatLng(userLatLng),
    );

    mapController.showMarkerInfoWindow(markerId);
  }
}
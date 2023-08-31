import 'package:get/get.dart';
import 'package:maps_routes_app/controller/mapController.dart';
import 'package:maps_routes_app/preferences/app_preference.dart';

class MainBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AppPreference>(()=> AppPreference(), fenix: true);
    Get.lazyPut<MapController>(()=> MapController(), fenix: true);
    
  }
}
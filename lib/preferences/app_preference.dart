// ignore_for_file: override_on_non_overriding_member


import 'package:get_storage/get_storage.dart';
import 'package:maps_routes_app/preferences/pref_helper.dart';


class AppPreference extends PreferenceHelper {
  var pref = GetStorage("AnglerMapPref");


  removePreference() {
    pref.erase();
  }

  
}

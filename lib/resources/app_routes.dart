
import 'package:get/get.dart';
import 'package:maps_routes_app/Features/Map/fetch_map.dart';
import 'package:maps_routes_app/Features/Map/map_page.dart';

class Routes {
  //this is to prevent anyone from instantiating this object
  Routes._();

  /// routes list
  static List<GetPage<dynamic>> routes = [
    GetPage(name: RouteNames.map, page: () => MapPage()),
    GetPage(name: RouteNames.fetchMap, page: () => FetchMap()),
    
  ];
}

class RouteNames {
  /// Your password screen
  static const map = '/map_page';
  static const fetchMap = '/fetch_map';
  
}

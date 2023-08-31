import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_routes_app/binding/main_binding.dart';
import 'package:maps_routes_app/resources/app_style.dart';

import '../../resources/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  buildNavigationDrawer(context) {
    return Drawer(
        backgroundColor: Color(0xFF134FAF),
        child: ListView(

            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF134FAF),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/logo_angler.png"),
                                        fit: BoxFit.contain,
                                        width: 140,
                                        height: 140,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Angler Tech',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Raleway",
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 25,
                ),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 25,
                ),
                title: const Text(
                  'Map',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  Get.toNamed(RouteNames.map);
                },
              ),
              Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 25,
                ),
                title: const Text(
                  'Fetch Map',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  Get.toNamed(RouteNames.fetchMap);
                },
              ),
              Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Angler Map Routes',
      theme: AppStyles.lightTheme(),
      initialBinding: MainBinding(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        ],
      getPages: Routes.routes,
      
      home: Scaffold(
        appBar: AppBar(
          // leading: Icon(
          //   Icons.menu,
          //   color: AppColors.white,
          // ),
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
            "Angler Google Maps",
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: 'Raleway'),
          ),
        ),
        drawer: buildNavigationDrawer(context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child:
                        Image(image: AssetImage("assets/images/angler.png"), fit: BoxFit.contain,
                        width: 350,),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text('WELCOME TO ANGLER TECHNOLOGIES',textAlign: TextAlign.center,
                                                 style: TextStyle(color: Color(0xFF134FAF) ,fontFamily: "Raleway", fontSize: 30, fontWeight: FontWeight.bold, ),),
                ),

                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Text('A pioneering India-based Internet-solutions company with offices worldwide. Our unique Full Service Provider (FSP) solutions model brings you the best of the worlds of Offshore Software Development, E-Business Products and Interactive Media.',textAlign: TextAlign.justify,
                                                   style: TextStyle(color: Colors.grey ,fontFamily: "Raleway", fontSize: 15, fontWeight: FontWeight.bold, ),),
                  ),
                ),

                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Text('How can YOU Benefit from ANGLER',textAlign: TextAlign.center,
                                                   style: TextStyle(color: Color(0xFF134FAF) ,fontFamily: "Raleway", fontSize: 30, fontWeight: FontWeight.bold, ),),
                  ),
                ),

                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Text('If you are an Independent Software Vendor (ISV) / Software Product Development Company or an exciting Technology Start-up, we can partner with you to either augment or outsource your development & testing needs for faster delivery and free up your valuable resources to focus on core business.',textAlign: TextAlign.justify,
                                                   style: TextStyle(color: Colors.grey ,fontFamily: "Raleway", fontSize: 15, fontWeight: FontWeight.bold, ),),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Text('Our ANGLER HeadStart is a unique Outsourced Product Development (OPD) model - a break-through software outsourcing model of partnering with ISVs and Software Product companies, making us the ideal Product Development Partne.',textAlign: TextAlign.justify,
                                                   style: TextStyle(color: Colors.grey ,fontFamily: "Raleway", fontSize: 15, fontWeight: FontWeight.bold, ),),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

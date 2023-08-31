import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maps_routes_app/preferences/app_preference.dart';

import '../resources/app_colors.dart';

class BaseController extends FullLifeCycleController with FullLifeCycleMixin {
  BuildContext? context;
    final scaffoldKey = new GlobalKey<ScaffoldState>();
  var isLoading = false.obs;
  final AppPreference appPreference = Get.find();
  final Connectivity _connectivity = Connectivity();

  setIsLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  hideSnackBar(BuildContext context) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
  }

  hideNetworkSnackbar(){
    Get.closeAllSnackbars();
  }

  showNetworkSnackbar(String msg){
    Get.snackbar(
        "",
        "",
        titleText: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('Connectivity Check',style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        messageText: Text('Please check your internet connection...',style: TextStyle(color: AppColors.black)),
        // 'Please check your internet connection...',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(days: 1),
        backgroundColor: AppColors.white,
        isDismissible: false,
        borderRadius: 0
    );
  }

  showSnackBar(String msg, context) {
    hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.red,
      content: Text(
        msg,
        style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal),
      ),
    ));
  }

  showSuccessSnackBar(String msg, context) {
    hideSnackBar(context);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFF134FAF),
      content: Text(
        msg,
        style: const TextStyle(
            color: AppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    ));
    
   
  }

  showSnackBarWithRetry(String msg, Function calledFunction, context) {
    hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(days: 1),
        action: SnackBarAction(
            label: "retry".tr,
            textColor: Colors.white,
            onPressed: () {
              isLoading.value = true;
              hideSnackBar(context);
              checkNetwork(context, calledFunction);
            })));
  }

  hideKeyBoard() {
    print("hideKeyBoard");
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  checkNetwork(context, Function calledFunction) async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        showSnackBarWithRetry("You are Offline", calledFunction, context);
      } else {
        // isLoading.value = true;
        hideSnackBar(context);
        calledFunction();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}

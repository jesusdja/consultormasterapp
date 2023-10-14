// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:consultormasterapp/global/send_data_background_provider.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum ConnectStatus {
  active,
  off,
}

class ConnectivityProvider extends ChangeNotifier {

  ConnectStatus connectStatus = ConnectStatus.off;
  late StreamSubscription subscription;

  ConnectivityProvider() {
    initialFunction();
  }

  Future initialFunction() async {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      refreshStatus(result);
    });
  }

  void refreshStatus(ConnectivityResult result){
    if(result == ConnectivityResult.none){
      connectStatus = ConnectStatus.off;
    }else{
      connectStatus = ConnectStatus.active;
      functionActiveRed();
    }
    notifyListeners();
  }

  Future functionActiveRed() async{
    await Future.delayed(const Duration(seconds: 3));
    Provider.of<SendDataBackGroundProvider>(contextHome,listen: false).getData();
  }

  bool isConnection(){
    return connectStatus == ConnectStatus.active;
  }

  disposes() {
    subscription.cancel();
  }
}

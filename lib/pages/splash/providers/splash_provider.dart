import 'package:consultormasterapp/services/shared_preferences_static.dart';
import 'package:flutter/material.dart';

enum SplashStatus {
  home,
  splash,
  login,
}

class SplashProvider extends ChangeNotifier {

  SplashStatus splashStatus = SplashStatus.splash;

  SplashProvider() {
    initSplash();
  }

  Future initSplash() async {
    int login = SharedPreferencesLocal.masterLogin;

    if(login == 0){
      splashStatus = SplashStatus.login;
    }
    if(login == 1){
      splashStatus = SplashStatus.home;
    }
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }
}

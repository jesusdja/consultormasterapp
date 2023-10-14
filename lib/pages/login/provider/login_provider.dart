import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {

  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  bool _obscureButton = true;
  bool get obscureButton => _obscureButton;
  set obscureButton(bool value){ _obscureButton = value; notifyListeners(); }

}
